# Setting windows powershell script execution policy

1. Right-click "Windows Power Shell"
2. Select "Run as Administrator"
3. Enter below command:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```
4. Check it worked:
```
> Get-ExecutionPolicy -List

        Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser       Undefined
 LocalMachine    RemoteSigned
```
5. You can now execute scripts