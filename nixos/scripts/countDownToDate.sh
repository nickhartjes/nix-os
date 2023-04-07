
# Create a bash function that will count down to a date
countDownToDate() {
    local targetDate=$2
    local currentDate=$(date +"%Y-%m-%d %H:%M:%S")
    local targetDateInSeconds=$(date -d "$targetDate" +"%s")
    local currentDateInSeconds=$(date -d "$currentDate" +"%s")
    local secondsLeft=$(($targetDateInSeconds - $currentDateInSeconds))

    local seconds=$((secondsLeft % 60))
    local minutes=$((secondsLeft / 60 % 60))
    local hours=$((secondsLeft / 3600 % 24))
    local days=$((secondsLeft / 86400))

    echo "$1:"
    echo "$days days, $hours hours, $minutes minutes and $seconds seconds left"
    echo "";
}

countDownToDate "Inleveren eindverslag" "2023-04-21 23:59:59"
