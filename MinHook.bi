#Ifdef __FB_64BIT__
    #INCLIB "minhook_x64"
#Else
    #INCLIB "minhook_x86"
#Endif

'MinHook 错误代码含意
'type MH_STATUS as long
'enum     
'    MH_UNKNOWN = -1                   'Unknown error. Should not be returned.    
'    MH_OK = 0                         'Successful.    
'    MH_ERROR_ALREADY_INITIALIZED = 2  'MinHook is already initialized.
'    MH_ERROR_NOT_INITIALIZED = 3      'MinHook is not initialized yet, or already uninitialized.    
'    MH_ERROR_ALREADY_CREATED = 4      'The hook for the specified target function is already created.
'    MH_ERROR_NOT_CREATED = 5          'The hook for the specified target function is not created yet.
'    MH_ERROR_ENABLED = 6              'The hook for the specified target function is already enabled.        
'    MH_ERROR_DISABLED = 7             'disabled. The hook for the specified target function is not enabled yet, or already
'    MH_ERROR_NOT_EXECUTABLE = 8       'and/or non-executable region. The specified pointer is invalid. It points the address of non-allocated    
'    MH_ERROR_UNSUPPORTED_FUNCTION = 9 'The specified target function cannot be hooked.    
'    MH_ERROR_MEMORY_ALLOC = 10        'Failed to allocate memory.    
'    MH_ERROR_MEMORY_PROTECT = 11      'Failed to change the memory protection.    
'    MH_ERROR_MODULE_NOT_FOUND = 12    'The specified module is not loaded.
'    MH_ERROR_FUNCTION_NOT_FOUND = 13  'The specified function is not found.
'end enum

'pTarget为MH_ALL_HOOKS时可对所有HOOK进行操作(EnableHook/DisableHook/RemoveHook)
#define MH_ALL_HOOKS NULL

'x86函数名问题vcpkg编译出来就这样，有时间再想办法
Extern "C"
   #Ifdef __FB_64BIT__
      Declare Function MH_Initialize() As long                           '初始化环境
      Declare Function MH_Uninitialize() As long                         '卸载环境
      Declare Function MH_RemoveHook(byval pTarget AS ANY PTR) AS LONG   '移除钩子
      Declare Function MH_EnableHook(byval pTarget AS ANY PTR) AS LONG   '开始钩子过滤
      Declare Function MH_DisableHook(byval pTarget AS ANY PTR) AS LONG  '停止钩子过滤
      Declare Function MH_StatusToString(byval status as long) AS string '错误代码翻译为错误提示
      Declare Function MH_CreateHook(byval pTarget as any ptr, byval pDetour as any ptr, byval ppOriginal as any ptr) AS LONG '挂钩函数   
      Declare Function MH_CreateHookApi(byval pszModule as LPCWSTR, BYVAL pszTarget as LPCSTR, BYVAL pDetour AS ANY PTR, BYVAL ppOriginal AS ANY PTR) AS LONG '挂钩API 
   #Else
      Declare Function MH_Initialize alias "MH_Initialize@0"() As long                           '初始化环境
      Declare Function MH_Uninitialize alias "MH_Uninitialize@0"() As long                       '卸载环境
      Declare Function MH_RemoveHook alias "MH_RemoveHook@4"(byval pTarget AS ANY PTR) AS LONG   '移除钩子
      Declare Function MH_EnableHook alias "MH_EnableHook@4"(byval pTarget AS ANY PTR) AS LONG   '开始钩子过滤
      Declare Function MH_DisableHook alias "MH_DisableHook@4"(byval pTarget AS ANY PTR) AS LONG  '停止钩子过滤
      Declare Function MH_StatusToString alias "MH_StatusToString@4"(byval status as long) AS string '错误代码翻译为错误提示
      Declare Function MH_CreateHook alias "MH_CreateHook@12"(byval pTarget as any ptr, byval pDetour as any ptr, byval ppOriginal as any ptr) AS LONG '挂钩函数   
      Declare Function MH_CreateHookApi alias "MH_CreateHookApi@16"(byval pszModule as LPCWSTR, BYVAL pszTarget as LPCSTR, BYVAL pDetour AS ANY PTR, BYVAL ppOriginal AS ANY PTR) AS LONG '挂钩API 
   #Endif

   '大概率用不到的函数
   'Declare Function MH_CreateHookApiEx(byval pszModule as LPCWSTR, BYVAL pszTarget as LPCSTR, BYVAL pDetour AS ANY PTR, BYVAL ppOriginal AS ANY PTR,byval ppTarget as any ptr) AS LONG      
   'Declare Function MH_QueueEnableHook(byval pTarget AS ANY PTR) AS LONG 'Queues to enable an already created hook.
   'Declare Function MH_QueueDisableHook(byval pTarget AS ANY PTR) AS LONG 'Queues to disable an already created hook.
   'Declare Function MH_ApplyQueued() AS LONG 'Applies all queued changes in one go.   
End Extern

