Creating ods output from proc report experimental

github
https://tinyurl.com/tywfcod
https://github.com/rogerjdeangelis/utl-creating-ods-output-table-from-proc-report-experimental

bart did the groundbreaking work on this method (crowd sourcing is amazing)
Bartosz Jablonski
yabwon@gmail.com

utl_odsRpt macro on end and in 'many macros'

SAS Forum: Transpose-Long-to-Wide

This should work if you can get any procedure output to have a one column header?
I turn headers off and use a title to hold pipe delimited column names;

SAS Forum
https://tinyurl.com/qt37yhb
https://communities.sas.com/t5/SAS-Programming/Transpose-Long-to-Wide-in-Enterprise-Guide/m-p/639897

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

related repos
https://tinyurl.com/vc7xvyc
https://github.com/rogerjdeangelis?tab=repositories&q=summarize+in%3Aname&type=&language=

Proc report is very flexible it can sort, transpose and summarixe. However the output ods table has
a very serious bug. It does not honor ods.
Minamally SAS could store compound naems in the _c#_ label?

* So far I have cooded macros for  (very experimental)

   utl_odsTab   - workaround for proc tablulate bug
   utl_odsFrq   - workaround for proc freq crosstab bug
   utl_odsRpt   - workaround for proc report crosstab bug

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data have;
 input ID TYPE$ COUNT SALES;
cards4;
1 First 23 156.0
1 Second 25 65147.0
1 Third 89 215654.0
1 Fourth 5 215.0
2 First 38 107964.0
2 Second 17 123032.4
2 Fourth 520 138100.8
3 Third 151 514785.0
;;;;
run;quit;

Up to 40 obs WORK.WNAT_OP total obs=8

  ID     TYPE     COUNT       SALES

   1    First       23        156.0
   1    Second      25      65147.0
   1    Third       89     215654.0
   1    Fourth       5        215.0
   2    First       38     107964.0
   2    Second      17     123032.4
   2    Fourth     520     138100.8
   3    Third      151     514785.0

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

* NOT THE BEST ORDER- Alphabetic - Ast's macro transpose can change the order;

Up to 40 obs from WANTODS total obs=3

       COUNT_    SALES_    COUNT_      SALES_    COUNT_     SALES_     COUNT_    SALES_
 ID     FIRST     FIRST    FOURTH      FOURTH    SECOND     SECOND      THIRD     THIRD

  1      23         156        5        215.0      25       65147.0       89     215654
  2      38      107964      520     138100.8      17      123032.4        .          .
  3       .           .        .           .        .            .       151     514785

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

%utl_odsrpt(setup);

proc report data=have split="" noheader  nowd box formchar='|';
* Alphabetic for crossed variables;
title "|ID|COUNT_FIRST |SALES_FIRST |COUNT_FOURTH |SALES_FOURTH |COUNT_SECOND |SALES_SECOND |COUNT_THIRD |SALES_THIRD|";
cols id  type,  ( count sales) ;
define id / group;
define type / across;
define sales / analysis;
define count / analysis;
run;quit;

%utl_odsrpt(outdsn=wantods);

*_
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
;

MLOGIC(UTL_ODSRPT):  Beginning execution.
MLOGIC(UTL_ODSRPT):  Parameter OUTDSN has value setup
SYMBOLGEN:  Macro variable OUTDSN resolves to setup
MLOGIC(UTL_ODSRPT):  %IF condition %qupcase(&outdsn)=SETUP is TRUE
MPRINT(UTL_ODSRPT):   filename _tmp1_ clear;
WARNING: No logical assign for filename _TMP1_.
MPRINT(UTL_ODSRPT):   * just in case;
MLOGIC(UTLFKIL):  Beginning execution.
MLOGIC(UTLFKIL):  Parameter UTLFKIL has value d:\wrk\_TD5684_E6420_/_tmp1_.txt
MLOGIC(UTLFKIL):  %LOCAL  URC
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable UTLFKIL resolves to d:\wrk\_TD5684_E6420_/_tmp1_.txt
SYMBOLGEN:  Macro variable URC resolves to 0
SYMBOLGEN:  Macro variable FNAME resolves to #LN00572
MLOGIC(UTLFKIL):  %IF condition &urc = 0 and %sysfunc(fexist(&fname)) is FALSE
MLOGIC(UTLFKIL):  %LET (variable name is URC)
MPRINT(UTLFKIL):   run;
MLOGIC(UTLFKIL):  Ending execution.
MPRINT(UTL_ODSRPT):  ;
MPRINT(UTL_ODSRPT):   filename _tmp1_ "d:\wrk\_TD5684_E6420_/_tmp1_.txt";
MLOGIC(UTL_ODSRPT):  %LET (variable name is _PS_)
MLOGIC(UTL_ODSRPT):  %LET (variable name is _FC_)
MPRINT(UTL_ODSRPT):   OPTIONS ls=max ps=32756 FORMCHAR='|' nodate nocenter;
MPRINT(UTL_ODSRPT):   title;
MPRINT(UTL_ODSRPT):   footnote;
MPRINT(UTL_ODSRPT):   proc printto print=_tmp1_;
MPRINT(UTL_ODSRPT):   run;
NOTE: PROCEDURE PRINTTO used (Total process time):
      real time           0.00 seconds
      user cpu time       0.00 seconds
      system cpu time     0.00 seconds
      memory              132.71k
      OS Memory           22532.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        699  Switch Count  0


MPRINT(UTL_ODSRPT):  quit;
MLOGIC(UTL_ODSRPT):  Ending execution.
3495   proc report data=have split="" noheader  nowd box formchar='|';
3496   title "|ID|COUNT_FIRST |SALES_FIRST |COUNT_FOURTH |SALES_FOURTH |COUNT_SECOND |SALES_SECOND |COUNT_THIRD |SALES_THIRD|";
3497   cols id  type,  ( count sales) ;
3498   define id / group;
3499   define type / across;
3500   define sales / analysis;
3501   define count / analysis;
3502   run;

NOTE: Multiple concurrent threads will be used to summarize data.
NOTE: There were 8 observations read from the data set WORK.HAVE.
NOTE: PROCEDURE REPORT used (Total process time):
      real time           0.01 seconds
      user cpu time       0.01 seconds
      system cpu time     0.00 seconds
      memory              12073.07k
      OS Memory           32796.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        700  Switch Count  0


3502 !     quit;
3503   %utl_odsrpt(outdsn=wantods);
MLOGIC(UTL_ODSRPT):  Beginning execution.
MLOGIC(UTL_ODSRPT):  Parameter OUTDSN has value wantods
SYMBOLGEN:  Macro variable OUTDSN resolves to wantods
MLOGIC(UTL_ODSRPT):  %IF condition %qupcase(&outdsn)=SETUP is FALSE
MPRINT(UTL_ODSRPT):   proc printto;
MPRINT(UTL_ODSRPT):   run;

NOTE: PROCEDURE PRINTTO used (Total process time):
      real time           0.00 seconds
      user cpu time       0.00 seconds
      system cpu time     0.00 seconds
      memory              6.68k
      OS Memory           22788.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        701  Switch Count  0


MPRINT(UTL_ODSRPT):  quit;
MPRINT(UTL_ODSRPT):   filename _tmp2_ clear;
WARNING: No logical assign for filename _TMP2_.
MLOGIC(UTLFKIL):  Beginning execution.
MLOGIC(UTLFKIL):  Parameter UTLFKIL has value d:\wrk\_TD5684_E6420_/_tmp2_.txt
MLOGIC(UTLFKIL):  %LOCAL  URC
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable UTLFKIL resolves to d:\wrk\_TD5684_E6420_/_tmp2_.txt
SYMBOLGEN:  Macro variable URC resolves to 0
SYMBOLGEN:  Macro variable FNAME resolves to #LN00573
MLOGIC(UTLFKIL):  %IF condition &urc = 0 and %sysfunc(fexist(&fname)) is FALSE
MLOGIC(UTLFKIL):  %LET (variable name is URC)
MPRINT(UTLFKIL):   run;
MLOGIC(UTLFKIL):  Ending execution.
MPRINT(UTL_ODSRPT):  ;
MPRINT(UTL_ODSRPT):   proc datasets lib=work nolist;
MPRINT(UTL_ODSRPT):   *just in case;
SYMBOLGEN:  Macro variable OUTDSN resolves to wantods
MPRINT(UTL_ODSRPT):   delete wantods;
MPRINT(UTL_ODSRPT):   run;

NOTE: Deleting WORK.WANTODS (memtype=DATA).
MPRINT(UTL_ODSRPT):  quit;
NOTE: PROCEDURE DATASETS used (Total process time):
      real time           0.01 seconds
      user cpu time       0.00 seconds
      system cpu time     0.01 seconds
      memory              243.43k
      OS Memory           22788.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        702  Switch Count  0


MPRINT(UTL_ODSRPT):   filename _tmp2_ "d:\wrk\_TD5684_E6420_/_tmp2_.txt";
MPRINT(UTL_ODSRPT):   data _null_;
MPRINT(UTL_ODSRPT):   infile _tmp1_ length=l;
MPRINT(UTL_ODSRPT):   input lyn $varying32756. l;
MPRINT(UTL_ODSRPT):   if countc(lyn,'|')>1;
MPRINT(UTL_ODSRPT):   lyn=compress(lyn);
MPRINT(UTL_ODSRPT):   putlog lyn;
MPRINT(UTL_ODSRPT):   file _tmp2_;
MPRINT(UTL_ODSRPT):   put lyn;
MPRINT(UTL_ODSRPT):   run;

NOTE: The infile _TMP1_ is:
      Filename=d:\wrk\_TD5684_E6420_\_tmp1_.txt,
      RECFM=V,LRECL=384,File Size (bytes)=848,
      Last Modified=15Apr2020:13:43:07,
      Create Time=15Apr2020:13:43:07

NOTE: The file _TMP2_ is:
      Filename=d:\wrk\_TD5684_E6420_\_tmp2_.txt,
      RECFM=V,LRECL=384,File Size (bytes)=0,
      Last Modified=15Apr2020:13:43:07,
      Create Time=15Apr2020:13:43:07



|ID|COUNT_FIRST|SALES_FIRST|COUNT_FOURTH|SALES_FOURTH|COUNT_SECOND|SALES_SECOND|COUNT_THIRD|SALES_THIRD|
|1|23|156|5|215|25|65147|89|215654|
|2|38|107964|520|138100.8|17|123032.4|.|.|
|3|.|.|.|.|.|.|151|514785|


NOTE: 9 records were read from the infile _TMP1_.
      The minimum record length was 0.
      The maximum record length was 111.
NOTE: 4 records were written to the file _TMP2_.
      The minimum record length was 26.
      The maximum record length was 104.
NOTE: DATA statement used (Total process time):
      real time           0.04 seconds
      user cpu time       0.00 seconds
      system cpu time     0.04 seconds
      memory              486.09k
      OS Memory           22788.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        703  Switch Count  0


MPRINT(UTL_ODSRPT):  quit;
SYMBOLGEN:  Macro variable OUTDSN resolves to wantods
MPRINT(UTL_ODSRPT):   proc import datafile=_tmp2_ dbms=dlm out=wantods(drop=VAR:) replace;
MPRINT(UTL_ODSRPT):   ADLM;
MPRINT(UTL_ODSRPT):   delimiter='|';
MPRINT(UTL_ODSRPT):   getnames=yes;
MPRINT(UTL_ODSRPT):   run;

Number of names found is less than number of variables found.
Name  is not a valid SAS name.
Problems were detected with provided names.  See LOG.
3504    /**********************************************************************
3505    *   PRODUCT:   SAS
3506    *   VERSION:   9.4
3507    *   CREATOR:   External File Interface
3508    *   DATE:      15APR20
3509    *   DESC:      Generated SAS Datastep Code
3510    *   TEMPLATE SOURCE:  (None Specified.)
3511    ***********************************************************************/
3512       data WORK.WANTODS (drop=VAR:)   ;
MPRINT(UTL_ODSRPT):   data WORK.WANTODS (drop=VAR:) ;
3513       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
3514       infile _TMP2_ delimiter = '|' MISSOVER DSD lrecl=384 firstobs=2 ;
MPRINT(UTL_ODSRPT):   infile _TMP2_ delimiter = '|' MISSOVER DSD lrecl=384 firstobs=2 ;
3515          informat VAR1 $1. ;
MPRINT(UTL_ODSRPT):   informat VAR1 $1. ;
3516          informat ID best32. ;
MPRINT(UTL_ODSRPT):   informat ID best32. ;
3517          informat COUNT_FIRST best32. ;
MPRINT(UTL_ODSRPT):   informat COUNT_FIRST best32. ;
3518          informat SALES_FIRST best32. ;
MPRINT(UTL_ODSRPT):   informat SALES_FIRST best32. ;
3519          informat COUNT_FOURTH best32. ;
MPRINT(UTL_ODSRPT):   informat COUNT_FOURTH best32. ;
3520          informat SALES_FOURTH best32. ;
MPRINT(UTL_ODSRPT):   informat SALES_FOURTH best32. ;
3521          informat COUNT_SECOND best32. ;
MPRINT(UTL_ODSRPT):   informat COUNT_SECOND best32. ;
3522          informat SALES_SECOND best32. ;
MPRINT(UTL_ODSRPT):   informat SALES_SECOND best32. ;
3523          informat COUNT_THIRD best32. ;
MPRINT(UTL_ODSRPT):   informat COUNT_THIRD best32. ;
3524          informat SALES_THIRD best32. ;
MPRINT(UTL_ODSRPT):   informat SALES_THIRD best32. ;
3525          informat VAR11 $1. ;
MPRINT(UTL_ODSRPT):   informat VAR11 $1. ;
3526          format VAR1 $1. ;
MPRINT(UTL_ODSRPT):   format VAR1 $1. ;
3527          format ID best12. ;
MPRINT(UTL_ODSRPT):   format ID best12. ;
3528          format COUNT_FIRST best12. ;
MPRINT(UTL_ODSRPT):   format COUNT_FIRST best12. ;
3529          format SALES_FIRST best12. ;
MPRINT(UTL_ODSRPT):   format SALES_FIRST best12. ;
3530          format COUNT_FOURTH best12. ;
MPRINT(UTL_ODSRPT):   format COUNT_FOURTH best12. ;
3531          format SALES_FOURTH best12. ;
MPRINT(UTL_ODSRPT):   format SALES_FOURTH best12. ;
3532          format COUNT_SECOND best12. ;
MPRINT(UTL_ODSRPT):   format COUNT_SECOND best12. ;
3533          format SALES_SECOND best12. ;
MPRINT(UTL_ODSRPT):   format SALES_SECOND best12. ;
3534          format COUNT_THIRD best12. ;
MPRINT(UTL_ODSRPT):   format COUNT_THIRD best12. ;
3535          format SALES_THIRD best12. ;
MPRINT(UTL_ODSRPT):   format SALES_THIRD best12. ;
3536          format VAR11 $1. ;
MPRINT(UTL_ODSRPT):   format VAR11 $1. ;
3537       input
3538                   VAR1  $
3539                   ID
3540                   COUNT_FIRST
3541                   SALES_FIRST
3542                   COUNT_FOURTH
3543                   SALES_FOURTH
3544                   COUNT_SECOND
3545                   SALES_SECOND
3546                   COUNT_THIRD
3547                   SALES_THIRD
3548                   VAR11  $
3549       ;
MPRINT(UTL_ODSRPT):   input VAR1 $ ID COUNT_FIRST SALES_FIRST COUNT_FOURTH SALES_FOURTH COUNT_SECOND SALES_SECOND COUNT_THIRD SALES_THIRD VAR11 $ ;
3550       if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
MPRINT(UTL_ODSRPT):   if _ERROR_ then call symputx('_EFIERR_',1);
3551       run;
MPRINT(UTL_ODSRPT):   run;

NOTE: The infile _TMP2_ is:
      Filename=d:\wrk\_TD5684_E6420_\_tmp2_.txt,
      RECFM=V,LRECL=384,File Size (bytes)=215,
      Last Modified=15Apr2020:13:43:07,
      Create Time=15Apr2020:13:43:07

NOTE: 3 records were read from the infile _TMP2_.
      The minimum record length was 26.
      The maximum record length was 42.
NOTE: The data set WORK.WANTODS has 3 observations and 9 variables.
NOTE: DATA statement used (Total process time):
      real time           0.10 seconds
      user cpu time       0.03 seconds
      system cpu time     0.07 seconds
      memory              9557.67k
      OS Memory           28324.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        704  Switch Count  0


3 rows created in WORK.WANTODS from _TMP2_.



NOTE: WORK.WANTODS data set was successfully created.
NOTE: The data set WORK.WANTODS has 3 observations and 9 variables.
NOTE: PROCEDURE IMPORT used (Total process time):
      real time           0.20 seconds
      user cpu time       0.06 seconds
      system cpu time     0.14 seconds
      memory              9557.67k
      OS Memory           28324.00k
      Timestamp           04/15/2020 01:43:07 PM
      Step Count                        704  Switch Count  10


MPRINT(UTL_ODSRPT):    ;
MPRINT(UTL_ODSRPT):   quit;
MPRINT(UTL_ODSRPT):   filename _tmp1_ clear;
NOTE: Fileref _TMP1_ has been deassigned.
MPRINT(UTL_ODSRPT):   filename _tmp2_ clear;
NOTE: Fileref _TMP2_ has been deassigned.
MLOGIC(UTLFKIL):  Beginning execution.
MLOGIC(UTLFKIL):  Parameter UTLFKIL has value d:\wrk\_TD5684_E6420_/_tmp1_.txt
MLOGIC(UTLFKIL):  %LOCAL  URC
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable UTLFKIL resolves to d:\wrk\_TD5684_E6420_/_tmp1_.txt
SYMBOLGEN:  Macro variable URC resolves to 0
SYMBOLGEN:  Macro variable FNAME resolves to #LN00574
MLOGIC(UTLFKIL):  %IF condition &urc = 0 and %sysfunc(fexist(&fname)) is TRUE
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable FNAME resolves to #LN00574
MLOGIC(UTLFKIL):  %LET (variable name is URC)
MPRINT(UTLFKIL):   run;
MLOGIC(UTLFKIL):  Ending execution.
MPRINT(UTL_ODSRPT):  ;
MLOGIC(UTLFKIL):  Beginning execution.
MLOGIC(UTLFKIL):  Parameter UTLFKIL has value d:\wrk\_TD5684_E6420_/_tmp2_.txt
MLOGIC(UTLFKIL):  %LOCAL  URC
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable UTLFKIL resolves to d:\wrk\_TD5684_E6420_/_tmp2_.txt
SYMBOLGEN:  Macro variable URC resolves to 0
SYMBOLGEN:  Macro variable FNAME resolves to #LN00575
MLOGIC(UTLFKIL):  %IF condition &urc = 0 and %sysfunc(fexist(&fname)) is TRUE
MLOGIC(UTLFKIL):  %LET (variable name is URC)
SYMBOLGEN:  Macro variable FNAME resolves to #LN00575
MLOGIC(UTLFKIL):  %LET (variable name is URC)
MPRINT(UTLFKIL):   run;
MLOGIC(UTLFKIL):  Ending execution.
MPRINT(UTL_ODSRPT):  ;
MLOGIC(UTL_ODSRPT):  Ending execution.


*
 _ __ ___   __ _  ___ _ __ ___
| '_ ` _ \ / _` |/ __| '__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

;



%macro utl_odsrpt(outdsn);

   %if %qupcase(&outdsn)=SETUP %then %do;

        filename _tmp1_ clear;  * just in case;

        %utlfkil(%sysfunc(pathname(work))/_tmp1_.txt);

        filename _tmp1_ "%sysfunc(pathname(work))/_tmp1_.txt";

        %let _ps_= %sysfunc(getoption(ps));
        %let _fc_= %sysfunc(getoption(formchar));

        OPTIONS ls=max ps=32756  FORMCHAR='|'  nodate nocenter;

        title; footnote;

        proc printto print=_tmp1_;
        run;quit;

   %end;
   %else %do;

        /* %let outdsn=tst;  */

        proc printto;
        run;quit;

        filename _tmp2_ clear;

        %utlfkil(%sysfunc(pathname(work))/_tmp2_.txt);

        proc datasets lib=work nolist;  *just in case;
         delete &outdsn;
        run;quit;

        filename _tmp2_ "%sysfunc(pathname(work))/_tmp2_.txt";

        data _null_;
          infile _tmp1_ length=l;
          input lyn $varying32756. l;
          if countc(lyn,'|')>1;
          lyn=compress(lyn);
          putlog lyn;
          file _tmp2_;
          put lyn;
        run;quit;

        proc import
           datafile=_tmp2_
           dbms=dlm
           out=&outdsn(drop=VAR:)
           replace;
           delimiter='|';
           getnames=yes;
        run;quit;

        filename _tmp1_ clear;
        filename _tmp2_ clear;

        %utlfkil(%sysfunc(pathname(work))/_tmp1_.txt);
        %utlfkil(%sysfunc(pathname(work))/_tmp2_.txt);

   %end;

%mend utl_odsrpt;


