component {

	property name="helper"      inject="PlatformHelper@disable-bot-sessions";
	property name="bots"        inject="Bots@disable-bot-sessions";
	property name="cookieCheck" inject="coldbox:setting:cookieCheck@disable-bot-sessions";

	function preProcess() {
		if ( notUsingCookies() || isLikelyBot() ) {
			helper.setSessionTimeout( 0, 0, 0, 1 );
		}
	}

	private function notUsingCookies() {
		if ( !variables.cookieCheck ) {
			return false;
		}

		return !structKeyExists( cookie, "CFID" ) || len( cookie[ "CFID" ] ) == 0;
	}

	private function isLikelyBot() {
		return variables.bots.keyExists( CGI.HTTP_USER_AGENT );
	}

}
