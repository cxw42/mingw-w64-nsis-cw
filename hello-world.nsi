# Don't need admin --- thanks for the pointer to 
# https://stackoverflow.com/users/7284356/rei at
# https://stackoverflow.com/a/45467958/2877364
RequestExecutionLevel user

# Don't pause when the installation is complete
AutoCloseWindow true

# set the name of the installer
Outfile "hello-world.exe"

Name "HelloWorld"
 
# create a default section.
Section
 
# create a popup box, with an OK button and the text "Hello world!"
MessageBox MB_OK "Hello world!"
 
SectionEnd

