
# enables remote login and remote management for the given user.

# ARD - let's enable remote management and add ADMINUSER
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users ADMINUSER -privs -all -restart -agent -menu

# Turn on remote login
systemsetup -setremotelogin on

# Create the com.apple.access_ssh group
dseditgroup -o create -q com.apple.access_ssh

# Add the ADMINGROUP group to com.apple.access_ssh
dseditgroup -o edit -a ADMINGROUP -t group com.apple.access_ssh
