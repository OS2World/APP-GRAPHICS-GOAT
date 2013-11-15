/* */
/* if this file is named PRJFIXCP.CMD then we are repairing a C++ project */
/* if this file is named PRJFIXC.CMD then we are repairing a C project */
/* if this file is named PRJFIXR.CMD then we are repairing a REXX project */

parse upper source sys type progname
if pos('PRJFIXCP', progname)<>0 then
  do
    say 'C++ Project Repair'
    classname='VPCPForm'
  end
else if pos('PRJFIXR', progname)<>0 then
  do
    say 'REXX Project Repair'
    classname='VPForm'
  end
else
  do
    say 'C Project Repair'
    classname='VPCForm'
  end

temparea='Temp!!.1!!'
sleeptime = 2

say''
say 'This utility will convert all Workplace Shell folders '
say 'in the current directory to VisPro Form objects.'
say ''
say 'This macro MUST be run from the project directory.'
say ''
say 'The damaged Project folder MUST be CLOSED before running'
say 'this program.'
say ''
say 'It is recommended that you back-up your project'
say 'before running this macro.'
say ''
say 'Repair now? (Y/N)'
pull response
if response <> 'Y' & response <> 'y' then
   return

classes.0 = 0
call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs

call SysQueryClassList 'CLASSES.'
found=0
if classes.0 = 0 then do
   say ''
   say ''
   say ''
   say 'There has been an error running REXX system '
   say 'functions.  Please open a NEW OS/2 window,  '
   say 'change to the effected project directory and'
   say 'run this application again.'
   say ''
   say ''
   say ''
   say 'Press <enter> to exit.'
   say ''
   say ''
   return
end  /* Do */
do i=1 to classes.0
   parse var classes.i name module
   if name==classname then
      found=1
end

if found==1 then
   say classname' is already registered as a Workplace Shell object'
else do
   rc=SysRegisterObjectClass(classname, classname)
   Call SysSleep sleeptime
   if rc==0 then do
     say '*****Error registering 'classname' object class'
     return
   end
end

projectdir='.\'
/* find the form directors by searching for FORM binary file */
rc=SysFileTree(projectdir'FORM', 'forms', 'sf')


do index=1 to forms.0
   /* strip off FORM to get the FORM dir name */
   lastslash=lastpos('\',forms.index)
   if lastslash<>0 then
     do
        forms.index=left(forms.index, lastslash-1)
     end

   /* strip off project path to get the FORM name */
   lastslash=lastpos('\',forms.index)
   if index==1 then do
      if lastslash<>0 then
        do
           projectdir=left(forms.index, lastslash-1)
           lastspace=lastpos(' ',projectdir)
           if lastspace<>0 then
              projectdir=right(projectdir, length(projectdir)-lastspace)
           rc=SysCreateObject(classname, temparea, projectdir)
           Call SysSleep sleeptime
           if rc==0 then do
              say '*****Error creating 'classname' object 'temparea
              return
           end
           '@rd 'temparea' 1>NUL 2>NUL'
           '@rd form 1>NUL 2>NUL'
           rc=SysCreateObject(CLASSNAME, 'Form', projectdir, "TEMPLATE=YES")
           Call SysSleep sleeptime
        end
   end
   if lastslash<>0 then
     do
        forms.index=right(forms.index, length(forms.index)-lastslash)
     end

   parse upper var forms.index upcase

   if upcase<>'SUBPROCS' then
     do
       if (classname=='VPForm' & upcase<>'THREADS') | (classname<>'VPForm' & upcase<>'SOURCE') then
         do
           say 'Found VisPro form 'forms.index
           say '   Repairing VisPro form 'forms.index
           '@md 'temparea
           Call SysSleep sleeptime
           say 'Moving Form Objects...'
           '@move 'forms.index'\*.* 'temparea
           Call SysSleep sleeptime
           rc=SysDestroyObject(projectdir'\'forms.index)
           Call SysSleep sleeptime

           if forms.index=='MAIN' then
              forms.index='Main'
           say 'Creating new Form'
           rc=SysCreateObject(classname, forms.index, projectdir)
           Call SysSleep sleeptime
           if rc==0 then do
              say '*****Error creating 'classname' object 'forms.index
              '@rename 'temparea' 'forms.index
              return
           end
           say 'Moving form object files'
           '@move 'temparea'\*.* 'forms.index
           Call SysSleep sleeptime
           '@rd 'temparea' 1>NUL 2>NUL'
         end

     end


end
'cls'
if forms.0==0 then do
   say ' '
   say ' '
   say ' '
   say ' '
   say '****No VisPro forms found'
   end
else do
   say ' '
   say ' '
   say ' '
   say ' '
   say 'Project repaired successfully'
   end
return
