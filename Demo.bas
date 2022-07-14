' WINFBE FORM
' WINFBE VERSION 1.9.1
' LOCKCONTROLS=False
' SNAPLINES=True
' WINFBE FORM_START
' WINFBE CONTROL_START Form
'   PROPERTIES_START
'     PROP_NAME=Name
'     PROP_VALUE=Form1
'     PROP_NAME=Left
'     PROP_VALUE=10
'     PROP_NAME=Top
'     PROP_VALUE=10
'     PROP_NAME=Width
'     PROP_VALUE=500
'     PROP_NAME=Height
'     PROP_VALUE=300
'     PROP_NAME=Text
'     PROP_VALUE=Form1
'     PROP_NAME=WindowState
'     PROP_VALUE=FormWindowState.Normal
'     PROP_NAME=StartPosition
'     PROP_VALUE=FormStartPosition.Manual
'     PROP_NAME=BorderStyle
'     PROP_VALUE=FormBorderStyle.Sizable
'     PROP_NAME=MinimizeBox
'     PROP_VALUE=True
'     PROP_NAME=MaximizeBox
'     PROP_VALUE=True
'     PROP_NAME=ControlBox
'     PROP_VALUE=True
'     PROP_NAME=Enabled
'     PROP_VALUE=True
'     PROP_NAME=Visible
'     PROP_VALUE=True
'     PROP_NAME=BackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=AcceptButton
'     PROP_VALUE=
'     PROP_NAME=AllowDrop
'     PROP_VALUE=False
'     PROP_NAME=KeyPreview
'     PROP_VALUE=False
'     PROP_NAME=CancelButton
'     PROP_VALUE=
'     PROP_NAME=Icon
'     PROP_VALUE=
'     PROP_NAME=Locked
'     PROP_VALUE=False
'     PROP_NAME=MaximumHeight
'     PROP_VALUE=0
'     PROP_NAME=MaximumWidth
'     PROP_VALUE=0
'     PROP_NAME=MinimumHeight
'     PROP_VALUE=0
'     PROP_NAME=MinimumWidth
'     PROP_VALUE=0
'     PROP_NAME=Tag
'     PROP_VALUE=
'   PROPERTIES_END
'   EVENTS_START
'   EVENTS_END
' WINFBE CONTROL_END
' WINFBE CONTROL_START Button
'   PROPERTIES_START
'     PROP_NAME=Name
'     PROP_VALUE=Button1
'     PROP_NAME=Left
'     PROP_VALUE=223
'     PROP_NAME=Top
'     PROP_VALUE=69
'     PROP_NAME=Width
'     PROP_VALUE=146
'     PROP_NAME=Height
'     PROP_VALUE=64
'     PROP_NAME=BackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=BackColorDown
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=BackColorHot
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=AllowDrop
'     PROP_VALUE=False
'     PROP_NAME=Font
'     PROP_VALUE=Segoe UI,9,400,0,0,0,1
'     PROP_NAME=TextForeColor
'     PROP_VALUE=SYSTEM|ControlText
'     PROP_NAME=TextBackColor
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=TextForeColorDown
'     PROP_VALUE=SYSTEM|ControlText
'     PROP_NAME=TextBackColorDown
'     PROP_VALUE=SYSTEM|Control
'     PROP_NAME=Image
'     PROP_VALUE=
'     PROP_NAME=ImageWidth
'     PROP_VALUE=16
'     PROP_NAME=ImageHeight
'     PROP_VALUE=16
'     PROP_NAME=ImageMargin
'     PROP_VALUE=4
'     PROP_NAME=ImageHighDPI
'     PROP_VALUE=True
'     PROP_NAME=Text
'     PROP_VALUE=Button1
'     PROP_NAME=TextAlign
'     PROP_VALUE=ButtonAlignment.MiddleCenter
'     PROP_NAME=TextMargin
'     PROP_VALUE=4
'     PROP_NAME=UseMnemonic
'     PROP_VALUE=True
'     PROP_NAME=ThemeSupport
'     PROP_VALUE=True
'     PROP_NAME=ToggleMode
'     PROP_VALUE=False
'     PROP_NAME=Enabled
'     PROP_VALUE=True
'     PROP_NAME=TabIndex
'     PROP_VALUE=1
'     PROP_NAME=TabStop
'     PROP_VALUE=True
'     PROP_NAME=Locked
'     PROP_VALUE=False
'     PROP_NAME=Tag
'     PROP_VALUE=
'     PROP_NAME=Visible
'     PROP_VALUE=True
'   PROPERTIES_END
'   EVENTS_START
'     EVENT_NAME=Click
'   EVENTS_END
' WINFBE CONTROL_END
' WINFBE FORM_END
' WINFBE_CODEGEN_START
#include once "WinFormsX\WinFormsX.bi"
Declare Function Form1_Button1_Click( ByRef sender As wfxButton, ByRef e As EventArgs ) As LRESULT

type Form1Type extends wfxForm
   private:
      temp as byte
   public:
      declare constructor
      ' Controls
      Button1 As wfxButton
end type

constructor Form1Type
   dim as long nClientOffset

   this.Text = "Form1"
   this.SetBounds(10,10,500,300)
   this.Button1.Parent = @this
   this.Button1.Text = "Button1"
   this.Button1.SetBounds(223,69-nClientOffset,146,64)
   this.Button1.OnClick = @Form1_Button1_Click
   this.Controls.Add(ControlType.Button, @this.Button1)
   Application.Forms.Add(ControlType.Form, @this)
end constructor

dim shared Form1 as Form1Type
' WINFBE_CODEGEN_END
#Include Once "windows.bi"

#Include Once "MinHook.bi"

' You should always include a resource file that references a valid manifest.xml
' file otherwise your application will not properly display Windows themed controls.
' Sample resource.rc and manifest.xml files can be found in the WinFBE \Settings folder.
' The following WinFBE directive includes the resource in your application. Simply
' uncomment the line.
' If you are using WinFBE's project management features then delete the following line
' because a resource file will be generated automatically.
'     '#RESOURCE "resource.rc"




''  Remove the following Application.Run code if it used elsewhere in your application.
Application.Run(Form1)

''
Common Shared MessageBoxAHook As Function (byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long
Declare Function MyMessageBoxA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long
Common Shared MessageBoxATarget as any ptr

Function MyMessageBoxA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long
   dim sTmp as String

   function = MessageBoxAHook(hWnd,lpText,"!!!!",uType)
end function

'挂载钩子
sub LoadAPIHook(byval DllName as string,byval APIName as string,byval MyHook as any ptr,byval NewAPIAddr as any ptr,byval sMode as long)
        ' dim Ret as long
        '  Ret = MH_CreateHookApi("user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook) 

   select case sMode
      case 1 'Mad SDK LineHook
         'MadHookAPI(DllName,APIName,MyHook,NewAPIAddr,0,32)
          
      CASE 2 'MiniHook SDK LineHook
         DIM wTmp as wstring * 512
         dim aTmp as zstring * 512
         wTmp = DllName
         aTmp = APIName

          MH_CreateHookApi(@wTmp,@aTmp,MyHook,NewAPIAddr)
         MH_CreateHookApi(@wTmp,@aTmp,@MyMessageBoxA,@MessageBoxAHook)
      case 3 'veh hook
         'SetVEHDR(DllName,APIName,MyHook,NewAPIAddr)         
   end select
end sub
sub abc()
         dim Ret as long
         'Ret = MH_Initialize
         'messageboxa 0,"1|","",0 
          Ret = MH_CreateHookApi("user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook)
         ' messageboxa 0,"2|","",0 
         ' MH_EnableHook(NULL)
         ' messageboxa 0,"3|","",0 
end sub


Function Form1_Button1_Click(ByRef sender As wfxButton, ByRef e As EventArgs ) As LRESULT
   dim Ret as Long
   dim sAPI as String
   dim sDll as string
   dim MyHook as any ptr
   dim NewAPIAddr as any ptr
   dim APITarget as any ptr
   
   
   
'   sAPI= STR("MessageBoxA")
'   sDll= STR("user32.dll")
'   MyHook =@MyMessageBoxA
'   NewAPIAddr=@MessageBoxAHook
'   APITarget=@MessageBoxATarget
   'Ret = MH_CreateHookApi("user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook,@MessageBoxATarget)
   'Ret = MH_CreateHookApi(sDll,sAPI,MyHook,NewAPIAddr,APITarget)
   'LoadAPIHook "user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook,@MessageBoxATarget,2
   'abc
   'Ret = MH_CreateHook(@MessageBoxA,@MyMessageBoxA,@MessageBoxAHook)
   

         Ret = MH_Initialize
         messageboxa 0,"中国人1|","",0 
          'Ret = MH_CreateHookApi("user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook)
          LoadAPIHook "user32.dll","MessageBoxA",@MyMessageBoxA,@MessageBoxAHook,2
          messageboxa 0,"2|","",0 
          MH_EnableHook(NULL)
          messageboxa 0,"3|","",0 
          
   'Ret = MH_EnableHook(MessageBoxATarget)
'MH_CreateHookApi(byval pszModule as LPCWSTR, BYVAL pszTarget as LPCSTR, BYVAL pDetour AS ANY PTR, BYVAL ppOriginal AS ANY PTR) AS LONG
   messageboxa 0,"123|" & ret,"",0 
   'MH_DisableHook(MH_ALL_HOOKS)
   'MH_DisableHook(MessageBoxATarget)
   messageboxa 0,"中国人|" & ret,"",0
   sleep 1
   messageboxa 0,"aaaa|" & ret,"",0
   Function = 0
End Function

