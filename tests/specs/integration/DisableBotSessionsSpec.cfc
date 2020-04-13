component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

	function beforeAll() {
		super.beforeAll();

		variables.helper = server.keyExists( "lucee" ) ? new models.helpers.LuceeHelper() : new models.helpers.ACFHelper();
	}

	function run() {
		describe( "disable-bot-sessions", function() {
			beforeEach( function() {
				// set default timeout
				helper.setSessionTimeout( 0, 0, 30, 0 );
				expect( getApplicationMetadata().sessionTimeout ).toBe(
					helper.createSessionTimeSpan( 0, 0, 30, 0 ),
					"beforeEach timeout not reset correctly"
				);
			} );

			it( "does nothing for normal sessions", function() {
				execute( route = "/" );
				expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 30, 0 ) );
			} );

			it( "disables sessions when a CFID cookie is not present", function() {
				var interceptor = getWireBox().getInstance( "interceptor-DisableBotSessions@disable-bot-sessions" );
				interceptor.configure();
				prepareMock( interceptor );
				interceptor.$( "notUsingCookies", true );
				getController()
					.getInterceptorService()
					.unregister( "DisableBotSessions@disable-bot-sessions" );
				getController()
					.getInterceptorService()
					.registerInterceptor( interceptorObject = interceptor );

				execute( route = "/" );
				expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 0, 1 ) );
			} );

			it( "does not disable sessions when a CFID cookie is not present but the cookie check is disabled", function() {
				var interceptor = getWireBox().getInstance( "interceptor-DisableBotSessions@disable-bot-sessions" );
				interceptor.configure();
				prepareMock( interceptor );
				interceptor.$( "notUsingCookies", true );
				interceptor.$property( propertyName = "cookieCheck", mock = false );
				getController()
					.getInterceptorService()
					.unregister( "DisableBotSessions@disable-bot-sessions" );
				getController()
					.getInterceptorService()
					.registerInterceptor( interceptorObject = interceptor );

				execute( route = "/" );
				expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 0, 1 ) );
			} );

			it( "disables sessions when a likely bot user agent string is present", function() {
				var interceptor = getWireBox().getInstance( "interceptor-DisableBotSessions@disable-bot-sessions" );
				interceptor.configure();
				prepareMock( interceptor );
				interceptor.$( "isLikelyBot", true );
				getController()
					.getInterceptorService()
					.unregister( "DisableBotSessions@disable-bot-sessions" );
				getController()
					.getInterceptorService()
					.registerInterceptor( interceptorObject = interceptor );

				execute( route = "/" );
				expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 0, 1 ) );
			} );
		} );
	}

}
