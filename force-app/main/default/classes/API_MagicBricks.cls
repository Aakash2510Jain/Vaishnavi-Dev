@RESTResource(urlMapping = '/magicBricks/*')
global class API_MagicBricks {
    @HttpPost
    global static String createLeadFromMagicBricks(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String body = req.requestBody.toString();
        Map<String, Object> requestBodyMap = (Map<String, Object>) JSON.deserializeUntyped(body);
        
        system.debug('requestBodyMap---->'+requestBodyMap);
        String urlValue = (string)requestBodyMap.get('url');//'http://app.sell.do/api/leads/create?source=Magic%20Bricks&mobile=9791155XXX&email=ashokraj.ok@gXXXX.com&time=145000&isd=Plaza%20Bounty%20Acres&name=Ashok%20Raj&msg=Plaza%20Bounty%20Acres,%20Chennai%20-%20I%20am%20interested%20in%20your%20project.%20Please%20contact%20me.%20Additional%20Details%20-%20Multistorey%20Apartment&project=Plaza%20Bounty%20Acres&dt=20180722&City=Chennai&api_key=aff532af1e2b22588a58XXXXXXXXXXXX';
        
        // Create a new URL instance
        System.PageReference pageReference = new System.PageReference( '/' + urlValue );
        Map<String, String> params = pageReference.getParameters();
        
        
        String source = params.get('source');
        String mobile = params.get('mobile');
        String email = params.get('email');
        String registrationTime = params.get('time');
        String isd = params.get('isd');
        String name = params.get('name');
        String msg = params.get('msg');
        String project = params.get('project');
        String dt = params.get('dt');
        String city = params.get('City');
        String apiKey = params.get('api_key');
        
        System.debug('source: ' + source);
        System.debug('mobile: ' + mobile);
        System.debug('email: ' + email);
        System.debug('registrationTime: ' + registrationTime);
        System.debug('isd: ' + isd);
        System.debug('name: ' + name);
        System.debug('msg: ' + msg);
        System.debug('project: ' + project);
        System.debug('dt: ' + dt);
        System.debug('city: ' + city);
        System.debug('api_key: ' + apiKey);
        return 'Success';
    }
}