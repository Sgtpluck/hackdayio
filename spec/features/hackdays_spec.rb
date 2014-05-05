require 'spec_helper'

# These tests make sure displaying a hackday works properly
describe "browsing hackdays" do

  before(:each) do
    @hackday = Fabricate(:hackday)
    @hack = Fabricate(:hack, hackday: @hackday)
  end

  describe "top view" do
    it "should order the hacks by votes" do
      best_hack = Fabricate(:hack, votes: 1000, title: "BEST HACK", hackday: @hackday)
      @hack.votes = 100
      worst_hack = Fabricate(:hack, votes: 0, title: "WORST HACK", hackday: @hackday)

      visit hackday_path(@hackday)
      page.body.index(best_hack.title).should < page.body.index(@hack.title)
      page.body.index(worst_hack.title).should > page.body.index(@hack.title)
    end

    it "should only show hacks from this hackday" do
      alt_hackday = Fabricate(:hackday)
      alt_hack = Fabricate(:hack, hackday: alt_hackday, title: "evil hack")

      visit hackday_path(@hackday)
      page.should have_content(@hack.title)
      page.should_not have_content(alt_hack.title)
    end
  end

  describe "presentation queue" do
    before(:each) do
      test_sign_in
      @current_user = User.last
      @hackday = Fabricate(:hackday)
      @hack = Fabricate(:hack, hackday: @hackday)
    end

    it "should let admins move hacks up in the presentation queue" do
      @hackday.admins << @current_user     
      hack2 = Fabricate(:hack, hackday: @hackday, presentation_index: 1)
      @hack.update_attribute(:presentation_index, 2)
      visit queue_hackday_path(@hackday)
      within('#hack_' + @hack.id.to_s) do
        click_on "Move Up"
      end

      find('.alert.alert-success').text.should have_content("has been moved up")
      page.should have_css('#hacks>:first-child h3', text: @hack.title)
    end

    it "should let admins move hacks down in the presentation queue" do
      @hackday.admins << @current_user     
      hack2 = Fabricate(:hack, hackday: @hackday, presentation_index: 2)
      @hack.update_attribute(:presentation_index, 1)
      visit queue_hackday_path(@hackday)
      within('#hack_' + @hack.id.to_s) do
        click_on "Move Down"
      end

      find('.alert.alert-success').text.should have_content("has been moved down")
      page.should have_css('#hacks>:last-child h3', text: @hack.title)
    end

    it "should let admins mark hacks as having been presented" do
      @hackday.admins << @current_user     
      @hack.update_attribute(:presentation_index, 1)
      visit queue_hackday_path(@hackday)
      within('#hack_' + @hack.id.to_s) do
        click_on "Presentation Completed"
      end

      find('.alert.alert-success').text.should have_content("This hack has been presented")
      page.should_not have_content(@hack.title)
    end

    it "should restrict queue manipulation to judges" do
      hack2 = Fabricate(:hack, hackday: @hackday, presentation_index: 2)
      @hack.update_attribute(:presentation_index, 1)
      visit queue_hackday_path(@hackday)

      page.should_not have_content("Presentation Completed")
      page.should_not have_content("Move Down")
      page.should_not have_content("Move up")
    end

    it "should show only the hacks that are ready to present" do
      visit queue_hackday_path(@hackday)
      page.should_not have_content(@hack.title)

      @hackday.join_queue(@hack)
      visit queue_hackday_path(@hackday)
      page.should have_content(@hack.title)
    end
  end

  describe "judges comments" do
    it "appears for judges" do
      test_sign_in
      @hackday.admins << User.last
      visit hackday_path(@hackday)

      page.should have_content("Judges Comments")
    end

    it "doesn't appear for non-judges" do
      visit hackday_path(@hackday)

      page.should_not have_content("Judges Comments")

      test_sign_in
      visit hackday_path(@hackday)

      page.should_not have_content("Judges Comments")
    end

    it "should only show private commments" do
      test_sign_in
      @hackday.admins << User.last
      comment = Fabricate(:comment, body: 'public comment', user: User.first, hack: @hack)
      private_comment = Fabricate(:comment, private: true, body: 'private comment', user: User.first, hack: @hack)

      visit judges_hackday_path(@hackday)
      page.should have_content('private comment')
      page.should_not have_content('public comment')
    end

  end

end