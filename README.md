## A Dev Box in the Cloud
While not always the case, more and more of your development work can move to the cloud.  This is made possible by a couple of things:
* Developer-friendly cloud infrastructure like [DigitalOcean](https://cloud.digitalocean.com)    
* Cloud-based IDE's like [Cloud 9](https://c9.io/), [Codeanywhere](https://codeanywhere.com/), [Koding](https://koding.com/), or [Nitrous](https://pro.nitrous.io/)   
 
### Current Approach
I want a setup where I have both direct ssh access to my cloud dev box as well access to it from a cloud ide.  The [Cloud 9](https://c9.io/)
IDE provides a web-based development environment.  They also allow you to use your own server.  The sweetness of this approach is that Cloud 9
useage is free.  Time will time, but this seems like a very reasonable approach to many of my work requirements.

### Prerequisites   
Before you can experience the goosebumps associated with writing code in the cloud, there's a few things you'll need first:
* [DigitalOcean](https://www.digitalocean.com/) account
* [Cloud9](https://c9.io/) account.  You can use your GitHub credentials
* [SSH](http://en.wikipedia.org/wiki/Secure_Shell) key pair.  Since you're using GitHub, you probably have a SSH key pair already. But to create a new pair:
  - from [Windows](https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-putty-on-digitalocean-droplets-windows-users)
  - from [Mac OS X or Linux](https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets)
  - **Note**: I'm not sure you need to copy your public key to DigitalOcean.  However, you'll definitely need it later.
* Fork this repo
* Clone your forked repo to your desktop
* Modify the cloud-init.sh script by replacing the following:
  - *==>DEVBOX_USERNAME<===*, with the Linux user name you want created with your new dev box
  - *==>PLAINTEXT_PASSWORD<===*, with a password (in plain text) you'll associate with the Linux user
  - *==>MY_SSH_PUBLIC_KEY<===*, with the contents of your SSH **public** key

### Provision a DigitalOcean Droplet
Now let's create our cloud dev box or in DigitalOcean parlance, a *"Droplet"*.

Create a droplet to host our projects:   
* Log onto [DigitalOcean](https://cloud.digitalocean.com)   
* Click [Create Droplet](https://cloud.digitalocean.com/droplets/new)   
* Name your Droplet (e.g. *"cloud9-ide"*)   
* Select Droplet size.  The **$5/month, 512MB, 20GB SSD** image size should be sufficient for getting started   
* Select Region   
* Available Settings:   
  - [x] Private Networking   
  - [x] Enable Backups   
  - [x] Enable User Data   
* Copy the contents of your [cloud-init.sh](cloud-init.sh) into the User Data text box      
* Select Image. In our case, select **Ubuntu 14.04 x64**   
* Click "Create Droplet" at the bottom of the screen   
* Wait a few minutes to let DigitalOcean do its thing   
* After the Droplet has been created, verify that you can ssh into your new box. Remember to use the user name specified in your cloud-init.sh   

### Create a Cloud9 Workspace
Now that you have a dev box in the cloud, create a Cloud9 workspace that leverages it:   
* Log onto [Cloud 9](https://c9.io/).    
* On the left nav area, click "Create New Workspace", and "Create a new workspace"
* In the "Create a New Workspace" dialog:   
  - Name your workspace (e.g. *"My-DigitalOcean-Dev-Box"*)   
  - Select a Workspace Privacy setting   
  - Hosting. You **must** select "SSH"  **Note:** By clicking SSH the following must be completed:      
  - Hostname. Enter the IP address of your DigitalOcean dev box Droplet      
  - Username. Enter the ssh user of your DigialOcean dev box Droplet   
  - Node.js Binary Path.  This should be something like "/usr/bin/nodejs"   
  - Your SSH key. Copy the public key you'll be using for ssh access to your DigitalOcean dev box Droplet and paste it here.   
  - Initial path. I believe this is optional.   
  - You should be ready to test your login.  Click "Login Test".  If all is well, after a few seconds you'll see a green message to the effect of "We're in!  You're good to go"   
* Click "Create".  This should close your new workspace dialog and take you back to your Cloud9 work area.   
* You should now see your new workspace under "My Projects" on the left nav.  Click on your new workspace name.   
* You should now see information about your workspace in the main workspace area of your screen.   
* Click "Start Editing".  This will open a new tab in your browser.   
* You will now probably see a "Cloud9 Setup" dialog.  Cloud9 wants to complete the install on your new DigitalOcean dev box.  Go ahead and let Cloud9 install the updates.  
* Assuming those updates are installed successfully, you should now have a Cloud9 workspace.    
* Go start writing some code!    

### Caveat Emptor
Some things to keep in mind:   
* This is a Linux-based environment.  If you have Windows requirements, you might want to try using Azure.   
* This workflow (incl. cloud-init.sh) has been tested...but only a few times.  If there's something wrong, or missing please fix and submit a pull request.   

### What's in the box? 
Mostly just your standard Linux dev tools:   
* **Version Control**: git, mercurial, subversion   
* **Utilities**: wget, curl, make, vim, tree   
* **Languages**: Python, Perl, Node.js   
* **Misc**: [cig](https://github.com/stevenjack/cig) is a command-line utility for identifying & reporting changes to your git repos.  It's pre-configured to track repos under */home/username/projects/*.  If 
you want to clone your repos into a different sub-directory, you'll need to change cloud-init.sh.
* **SSH**: Root access has been disabled   

