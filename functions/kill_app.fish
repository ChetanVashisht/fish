# Define a function to kill all instances of a specified application
function kill_app --description "Kill all instances of a specified application"
    # Check if an application name is provided as an argument
    if test (count $argv) -eq 0
        echo "Usage: kill_app <application_name>"
        echo "Example: kill_app node"
        return 1
    end

    set app_name $argv[1]

    echo "Attempting to kill all instances of '$app_name'..."

    # Use pidof to get process IDs (PIDs) of the specified application
    # and then use xargs to pass each PID to 'kill -9' for forceful termination.
    # '2>/dev/null' suppresses any error messages from pidof if the app is not running.
    pidof $app_name | xargs -r kill -9

    # Check the exit status of the previous command
    if test $status -eq 0
        echo "Successfully sent kill signal to all instances of '$app_name'."
    else if test $status -eq 127 # xargs returns 127 if no arguments were passed (i.e., pidof found nothing)
        echo "No instances of '$app_name' found."
    else
        echo "An error occurred while trying to kill instances of '$app_name'."
        echo "Please check if the application name is correct or if you have the necessary permissions."
        return 1
    end
end

# To make this function available every time you open a fish shell,
# add it to your ~/.config/fish/functions/kill_app.fish file,
# or directly to your ~/.config/fish/config.fish file.

# Example usage (after adding the function):
# kill_app node
# kill_app firefox
