Network Accounts lose local admin credentials off network
---------
Network Accounts lose local admin credentials when they go off network because they can't connect to the AD DC.

Use this script:

https://jamfnation.jamfsoftware.com/discussion.html?id=7427

OR run this command:

```
sudo dseditgroup -o edit -a bbeaty -t user admin
```
