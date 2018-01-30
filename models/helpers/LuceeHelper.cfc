component {

    function setSessionTimeout( days, hours, minutes, seconds ) {
        cfapplication(
            action = "update",
            sessionTimeout = createSessionTimeSpan( days, hours, minutes, seconds )
        );
    }

    function createSessionTimeSpan( days, hours, minutes, seconds ) {
        return createTimeSpan( days, hours, minutes, seconds );
    }

}
