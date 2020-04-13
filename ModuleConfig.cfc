component {

	this.name          = "disable-bot-sessions";
	this.author        = "Eric Peterson";
	this.webUrl        = "https://github.com/elpete/disable-bot-sessions";
	this.mapping       = "disable-bot-sessions";
	this.autoMapModels = false;
	this.dependencies  = [ "cbstorages" ];

	function configure() {
		settings = {
			"cookieCheck"  : true,
			"botsJsonFile" : "#moduleMapping#/config/bots.json"
		};

		binder.map( "PlatformHelper@disable-bot-sessions" ).to( getPlatformHelperPath() );
		binder
			.map( "Bots@disable-bot-sessions" )
			.toValue( deserializeJSON( fileRead( expandPath( settings.botsJsonFile ) ) ) );

		interceptors = [
			{
				"class" : "#moduleMapping#.interceptors.DisableBotSessions",
				"name"  : "DisableBotSessions"
			}
		];
	}


	function getPlatformHelperPath() {
		return server.keyExists( "lucee" ) ? "#moduleMapping#.models.helpers.LuceeHelper" : "#moduleMapping#.models.helpers.ACFHelper";
	}

}
