

We are using our individual windows credentials to connect dev/ITG/STG/PROD HPE IDS databases. 

Note – For DB/Tidal Jobs are scheduled with DMUSer01 users on ITG/STG and PROD environment.

So you can use same Tidal user for bot. Its windows credentials.

Dev DB Connectivity:- Use individual windows credentials to test the bot.
Data Source=10.84.81.3\SQLDB0003DEV,1102;Initial Catalog=HPFSIDS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;
ITG DB Connectivity:- Use Tidal User windows credentials  to test the bot on ITG
Data Source=i2wg11981.dc02.its.hpecorp.net,1103;Initial Catalog=HPFSIDSI;Provider=SQLNCLI11.1;User ID=DMUsr01;Password=WIPROusr02UAT21!;Auto Translate=False;

STG DB Connectivity:- Use Tidal User windows credentials to test the bot on STG
              Data Source=i2wg101854.dc02.its.hpecorp.net,1141;Initial Catalog=HPFSIDSQ;Provider=SQLNCLI11.1;User ID=DMUsr01;Password=WIPROusr02UAT21!;Auto Translate=False;

PROD DB Connectivity:- Use individual windows credentials to test the bot on PROD. Prod Tidal User windows credentials  are not available with us. 
              Data Source=10.84.81.3\SQLDB0003DEV,1102;Initial Catalog=HPFSIDS;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;

Please note, all above database can be connect only with HPE credentials, you can discuss/connect with Vikas for HPE connectivity issues.

my linkedin: https://www.linkedin.com/in/manish-kumar-5039a3181/
