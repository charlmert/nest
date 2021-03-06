# octoplasm possible stat watch point
mysql -utera -ppassword tera_wurfl -e "show tables like 'TeraWurfl\_%';"

OUTPUT:
+-------------------------------------+
| Tables_in_tera_wurfl (TeraWurfl\_%) |
+-------------------------------------+
| TeraWurfl_AOL                       |
| TeraWurfl_Alcatel                   |
| TeraWurfl_Android                   |
| TeraWurfl_Apple                     |
| TeraWurfl_BenQ                      |
| TeraWurfl_BlackBerry                |
| TeraWurfl_Bot                       |
| TeraWurfl_CatchAll                  |
| TeraWurfl_Chrome                    |
| TeraWurfl_DoCoMo                    |
| TeraWurfl_Firefox                   |
| TeraWurfl_Grundig                   |
| TeraWurfl_HTC                       |
| TeraWurfl_Kddi                      |
| TeraWurfl_Konqueror                 |
| TeraWurfl_Kyocera                   |
| TeraWurfl_LG                        |
| TeraWurfl_MSIE                      |
| TeraWurfl_Mitsubishi                |
| TeraWurfl_Motorola                  |
| TeraWurfl_Nec                       |
| TeraWurfl_Nintendo                  |
| TeraWurfl_Nokia                     |
| TeraWurfl_Opera                     |
| TeraWurfl_OperaMini                 |
| TeraWurfl_Panasonic                 |
| TeraWurfl_Pantech                   |
| TeraWurfl_Philips                   |
| TeraWurfl_Portalmmm                 |
| TeraWurfl_Qtek                      |
| TeraWurfl_SPV                       |
| TeraWurfl_Safari                    |
| TeraWurfl_Sagem                     |
| TeraWurfl_Samsung                   |
| TeraWurfl_Sanyo                     |
| TeraWurfl_Sharp                     |
| TeraWurfl_Siemens                   |
| TeraWurfl_SonyEricsson              |
| TeraWurfl_Toshiba                   |
| TeraWurfl_Vodafone                  |
| TeraWurfl_WindowsCE                 |
+-------------------------------------+

SOLUTION:
# remove pipes and formatting, trying to get the raw tables
sed s#\|##g

RESULT:
mysql -utera -ppassword tera_wurfl -e "show tables like 'TeraWurfl\_%';" | sed s#\|##g

OUTPUT:
Tables_in_tera_wurfl (TeraWurfl\_%)
TeraWurfl_AOL
TeraWurfl_Alcatel
TeraWurfl_Android
TeraWurfl_Apple
TeraWurfl_BenQ
TeraWurfl_BlackBerry
TeraWurfl_Bot
TeraWurfl_CatchAll
TeraWurfl_Chrome
TeraWurfl_DoCoMo
TeraWurfl_Firefox
TeraWurfl_Grundig
TeraWurfl_HTC
TeraWurfl_Kddi
TeraWurfl_Konqueror
TeraWurfl_Kyocera
TeraWurfl_LG
TeraWurfl_MSIE
TeraWurfl_Mitsubishi
TeraWurfl_Motorola
TeraWurfl_Nec
TeraWurfl_Nintendo
TeraWurfl_Nokia
TeraWurfl_Opera
TeraWurfl_OperaMini
TeraWurfl_Panasonic
TeraWurfl_Pantech
TeraWurfl_Philips
TeraWurfl_Portalmmm
TeraWurfl_Qtek
TeraWurfl_SPV
TeraWurfl_Safari
TeraWurfl_Sagem
TeraWurfl_Samsung
TeraWurfl_Sanyo
TeraWurfl_Sharp
TeraWurfl_Siemens
TeraWurfl_SonyEricsson
TeraWurfl_Toshiba
TeraWurfl_Vodafone
TeraWurfl_WindowsCE

SOLUTION:
# need to remove the header, candidate command is tail, needs line count to calculate what to negate i.e. first line from the top
wc -l

RESULT:
mysql -utera -ppassword tera_wurfl -e "show tables like 'TeraWurfl\_%';" | sed s#\|##g | wc -l

OUTPUT:
42

SOLUTION:
tail -41

RESULT:
#tables to use
mysql -utera -ppassword tera_wurfl -e "show tables like 'TeraWurfl\_%';" | sed s#\|##g | tail -41

OUTPUT:
TeraWurfl_AOL
TeraWurfl_Alcatel
TeraWurfl_Android
TeraWurfl_Apple
TeraWurfl_BenQ
TeraWurfl_BlackBerry
TeraWurfl_Bot
TeraWurfl_CatchAll
TeraWurfl_Chrome
TeraWurfl_DoCoMo
TeraWurfl_Firefox
TeraWurfl_Grundig
TeraWurfl_HTC
TeraWurfl_Kddi
TeraWurfl_Konqueror
TeraWurfl_Kyocera
TeraWurfl_LG
TeraWurfl_MSIE
TeraWurfl_Mitsubishi
TeraWurfl_Motorola
TeraWurfl_Nec
TeraWurfl_Nintendo
TeraWurfl_Nokia
TeraWurfl_Opera
TeraWurfl_OperaMini
TeraWurfl_Panasonic
TeraWurfl_Pantech
TeraWurfl_Philips
TeraWurfl_Portalmmm
TeraWurfl_Qtek
TeraWurfl_SPV
TeraWurfl_Safari
TeraWurfl_Sagem
TeraWurfl_Samsung
TeraWurfl_Sanyo
TeraWurfl_Sharp
TeraWurfl_Siemens
TeraWurfl_SonyEricsson
TeraWurfl_Toshiba
TeraWurfl_Vodafone
TeraWurfl_WindowsCE
