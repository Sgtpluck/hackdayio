This is the tool we use at Yammer to keep track of our epic hack days

What this thing does
-----------------------------

Track your company's hack days. 

* Anyone can sign up, create or join a hack and vote on hacks
* Judges can make private comments and move things up and down in the presentation queue


Setting up Authentication
------------------------------------

We use Omniauth (link) - this app is set up to use either Github or Yammer for auth, but it should be pretty straight forward to use another provider - check out the OmniAuth docs (link)

1. Figure out the URL you're going to use to host this
2. Go to the developer page for Github (link) or Yammer (link) and create a new app - name it and give it a good description so people don't freak out when they're asked to give your site permission
3. Edit omniauth.rb and fill in your key and secret
4. Edit settings.yml to include the (this just sets some stuff in the UI)
5. Deploy your app
6. There is no step 6

Anticipated Questions
--------------------------------

Q: This code is terrible - was it written by a PM?
A: Yes.

Q: Is it mean to vote down hacks?
A: Yes. 

Q: Does it work on mobile?
A: Yes.

Q: Can I have feature ___?
A: Maybe. Send a pull request.

Q: Can I help?
A: Heck yes. Send pull requests.
