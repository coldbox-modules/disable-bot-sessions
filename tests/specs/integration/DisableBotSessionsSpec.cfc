component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();

        variables.helper = server.keyExists( "lucee" ) ?
            new models.helpers.LuceeHelper() :
            new models.helpers.ACFHelper();
    }

    function run() {
        describe( "disable-bot-sessions", function() {
            beforeEach( function() {
                // set default timeout
                helper.setSessionTimeout( 0, 0, 30, 0 );
            } );

            it( "does nothing for normal sessions", function() {
                execute( route = "/" );
                expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 30, 0 ) );
            } );

            it( "disables sessions when a CFID cookie is not present", function() {
                var interceptor = getWireBox().getInstance( "interceptor-DisableBotSessions" );
                interceptor.configure();
                prepareMock( interceptor );
                var mockCookieStorage = createStub().$( "exists", false );
                interceptor.$property( propertyName = "cookieStorage", mock = mockCookieStorage );
                getController().getInterceptorService().unregister( "DisableBotSessions" );
                getController().getInterceptorService().registerInterceptor( interceptorObject = interceptor );

                execute( event = "Main.index" );
                expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 0, 1 ) );
            } );

            it( "disables sessions when a likely bot user agent string is present", function() {
                var interceptor = getWireBox().getInstance( "interceptor-DisableBotSessions" );
                interceptor.configure();
                prepareMock( interceptor );
                var mockCGI = createStub().$( "exists", true );
                interceptor.$property( propertyName = "CGIScope", mock = mockCGI );
                getController().getInterceptorService().unregister( "DisableBotSessions" );
                getController().getInterceptorService().registerInterceptor( interceptorObject = interceptor );

                execute( route = "/" );
                expect( getApplicationMetadata().sessionTimeout ).toBe( helper.createSessionTimeSpan( 0, 0, 0, 1 ) );
            } );
        } );
    }

}
