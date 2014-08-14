window.intercomSettings = {
	// TODO: The current logged in user's full name
	name: "John Doe",
	// TODO: The current logged in user's email address.
	email: "john.doe@example.com",
	// TODO: The current logged in user's sign-up date as a Unix timestamp.
	created_at: 1234567890,
	app_id: "ti1y7xb6"
};

(function(){var w=window;var ic=w.Intercom;if(typeof ic==="function"){ic('reattach_activator');ic('update',intercomSettings);}else{var d=document;var i=function(){i.c(arguments)};i.q=[];i.c=function(args){i.q.push(args)};w.Intercom=i;function l(){var s=d.createElement('script');s.type='text/javascript';s.async=true;s.src='https://static.intercomcdn.com/intercom.v1.js';var x=d.getElementsByTagName('script')[0];x.parentNode.insertBefore(s,x);}if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})()

(function (i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function () {
				(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o),
		m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-41537918-6', 'enroll.oplerno.com');
ga('set', 'forceSSL', true);
ga('require', 'linkid', 'linkid.js');
ga('require', 'displayfeatures');
ga('send', 'pageview');
