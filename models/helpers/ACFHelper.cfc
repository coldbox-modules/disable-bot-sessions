component {

    variables.allowedAttributes = [
        "datasource",
        "name",
        "applicationtimeout",
        "clientmanagement",
        "clientstorage",
        "loginstorage",
        "passarraybyreference",
        "searchimplicitscopes",
        "googlemapkey",
        "scriptprotect",
        "serversideformvalidation",
        "sessionmanagement",
        "sessiontimeout",
        "setclientcookies",
        "setdomaincookies",
        "compileextforinclude",
        "strictnumbervalidation"
    ];

    function setSessionTimeout( days, hours, minutes, seconds ) {
        var settings = getApplicationMetadata();
        var mappings = settings.mappings;
        settings = settings.filter( function( key ) {
            return allowedAttributes.contains( lcase( key ) );
        } );
        if ( settings.keyExists( "scriptprotect" ) ) {
            settings[ "scriptprotect" ] = settings.scriptprotect.toList();
        }
        settings.sessionTimeout = createTimeSpan( days, hours, minutes, seconds );
        cfapplication( attributeCollection = settings );
        var newSettings = getApplicationMetadata();
        mappings.each( function( name, path ) {
            newSettings.mappings[ name ] = path;
        } );
    }

    function createSessionTimeSpan( days, hours, minutes, seconds ) {
        return days * 24 * 60 * 60 +
            hours * 60 * 60 +
            minutes * 60 +
            seconds;
    }

}
