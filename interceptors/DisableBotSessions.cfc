component {

    property name="cookieStorage" inject="CookieStorage@cbstorages";
    property name="CGIScope"      inject="CGIScope@disable-bot-sessions";
    property name="helper"        inject="PlatformHelper@disable-bot-sessions";

    function configure() {
        variables.bots = deserializeJSON(
            fileRead( expandPath( "../config/bots.json" ) )
        );
    }

    function preProcess() {
        if ( notUsingCookies() || isLikelyBot() ) {
            helper.setSessionTimeout( 0, 0, 0, 1 );
        }
    }

    private function notUsingCookies() {
        return ! cookieStorage.exists( "CFID" ) || len( cookieStorage.getVar( "CFID" ) ) == 0;
    }

    private function isLikelyBot() {
        return CGIScope.exists( CGI.HTTP_USER_AGENT );
    }

}
