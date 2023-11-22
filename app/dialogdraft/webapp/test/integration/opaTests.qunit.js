sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/dialogdraft/test/integration/FirstJourney',
		'ns/dialogdraft/test/integration/pages/PersonSetList',
		'ns/dialogdraft/test/integration/pages/PersonSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, PersonSetList, PersonSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/dialogdraft') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePersonSetList: PersonSetList,
					onThePersonSetObjectPage: PersonSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);