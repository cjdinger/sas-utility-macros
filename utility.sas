/* Reliable way to check whether a macro value is empty/blank */
%macro isBlank(param);
  %sysevalf(%superq(param)=,boolean)
%mend;

/* We need this function for large file uploads, to telegraph */
/* the file size in the API.                                   */
/* Get the file size of a local file in bytes.                */
%macro getFileSize(localFile=);
  %local rc fid fidc;
  %local File_Size;
  %let File_Size = -1;
  %let rc=%sysfunc(filename(_lfile,&localFile));
  %if &rc. = 0 %then %do; 
    %let fid=%sysfunc(fopen(&_lfile));
    %if &fid. > 0 %then %do;
      %let File_Size=%sysfunc(finfo(&fid,File Size (bytes)));
      %let fidc=%sysfunc(fclose(&fid));
    %end;
    %let rc=%sysfunc(filename(_lfile));
  %end;
  %sysevalf(&File_Size.)
%mend;