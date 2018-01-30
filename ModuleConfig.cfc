component {

    this.name = "disable-bot-sessions";
    this.author = "Eric Peterson";
    this.webUrl = "https://github.com/elpete/disable-bot-sessions";
    this.mapping = "disable-bot-sessions";
    this.autoMapModels = false;
    this.dependencies = [ "cbstorages" ];

    function configure() {
        interceptors = [
            { class = "#moduleMapping#.interceptors.DisableBotSessions" }
        ];

        binder.map( "CGIScope@disable-bot-sessions" )
            .to( "#moduleMapping#.models.CGIScope" );
        binder.map( "PlatformHelper@disable-bot-sessions" )
            .to( getPlatformHelperPath() );
    }

    function getPlatformHelperPath() {
        return server.keyExists( "lucee" ) ?
            "#moduleMapping#.models.helpers.LuceeHelper" :
            "#moduleMapping#.models.helpers.ACFHelper";

    }
}
