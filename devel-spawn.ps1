class dvlp_process {
    [String]$proc_cmd
    [String]$proc_wait
    [String]$proc_noexit
    [String]$proc_exit
    [String]$proc_style
    [String]$proc_nowin

    hidden init ([string]$proc_cmd) {
        $this.init($proc_cmd, '')
    }

    hidden init ([string]$proc_cmd, [string]$proc_wait) {
        $this.init($proc_cmd, $proc_wait, '')
    }

    hidden init ([string]$proc_cmd, [string]$proc_wait, [string]$proc_noexit) {
        $this.re_set()
        if (!([String]::IsNullOrEmpty($proc_cmd))) {
            $this.proc_cmd = $proc_cmd
        }
        else {
            $this.proc_cmd = ''
        }
        if ([string]::IsNullOrEmpty($this.proc_nowin)){
            if (!([String]::IsNullOrEmpty($proc_wait))) {
                $this.proc_wait = "wait"
            }
            else {
                $this.proc_wait = ''
            }
            if (!([String]::IsNullOrEmpty($proc_noexit))) {
                $this.proc_noexit = '-noexit'
            }
            else {
                $this.proc_noexit = ''
            } 
        } else {
            write-host "start process powershell -nonewwindow -argument list $($this.proc_cmd)"
            $this.proc_wait = ''
            $this.proc_noexit = ''
        }
        # $this.start()
    }
    dvlp_process (
        [string]$proc_cmd
    ) {
        $this.init($proc_cmd, '')
    }
    dvlp_process (
        [string]$proc_cmd,
        [string]$proc_wait
    ) {
        $this.init($proc_cmd, $proc_wait)
    }
    dvlp_process (
        [string]$proc_cmd,
        [string]$proc_wait,
        [string]$proc_noexit
    ) {
        $this.init($proc_cmd, $proc_wait, $proc_noexit)
    }

    re_set () {
        if (([string]::IsNullOrEmpty($env:KINDTEK_NEW_PROC_NOEXIT))) {
            $this.proc_noexit = ""
        }
        else {
            $this.proc_noexit = "-noexit"
        }
        write-host "noexit: $($this.proc_noexit)"
        if ([string]::IsNullOrEmpty($env:KINDTEK_NEW_PROC_STYLE)) {
            $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::Normal
        }
        else {
            $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::$env:KINDTEK_NEW_PROC_STYLE
        }
        write-host "style: $($this.proc_style)"
    }

    [bool]start() {
        if (([string]::IsNullOrEmpty($this.proc_cmd))) {
            return $false
        }
        if (!([string]::IsNullOrEmpty($this.proc_nowin))){
            $proc_show = @{
                NoNewWindow = $null
            }    
        }  elseif ([string]::IsNullOrEmpty($this.proc_style)){
            $proc_show = @{
                WindowStyle = $($this.proc_style)
            }    
        } else {
            $proc_show = @{
                WindowStyle = $($this.proc_style)
                Wait = $null
            }
        }
        
        try {
            if ([string]::IsNullOrEmpty($this.proc_noexit)){
                # Start-Process -Filepath powershell.exe @proc_show -ArgumentList $($this.proc_noexit), '-Command', $($this.proc_cmd)
                Start-Process -Filepath powershell.exe @proc_show -ArgumentList '-Command', $($this.proc_cmd)
            } else {
                # Start-Process -Filepath powershell.exe @proc_show -ArgumentList $($this.proc_noexit), '-Command', $($this.proc_cmd)
                Start-Process -Filepath powershell.exe @proc_show -ArgumentList $($this.proc_noexit), '-Command', $($this.proc_cmd)
            }
        }
        catch { 
            return $false 
        }
        return $true
    }
}

class dvlp_process_quiet : dvlp_process {
    [String]$proc_exit
    [String]$proc_noexit
    [String]$proc_style

    dvlp_process_quiet([string]$proc_cmd) : base($proc_cmd){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_quiet([string]$proc_cmd, [string]$proc_wait) : base($proc_cmd, $proc_wait){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_quiet([string]$proc_cmd, [string]$proc_wait, [string]$proc_noexit) : base($proc_cmd, $proc_wait, $proc_noexit){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    re_set () {
        $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::Hidden
    }
}

class dvlp_process_popmax : dvlp_process {
    [String]$proc_exit
    [String]$proc_noexit
    [String]$proc_style

    dvlp_process_popmax([string]$proc_cmd) : base($proc_cmd){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_popmax([string]$proc_cmd, [string]$proc_wait) : base($proc_cmd, $proc_wait){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_popmax([string]$proc_cmd, [string]$proc_wait, [string]$proc_noexit) : base($proc_cmd, $proc_wait, $proc_noexit){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    re_set () {
        $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::Maximized
    }
}

class dvlp_process_same : dvlp_process {
    [String]$proc_exit
    [String]$proc_noexit
    [String]$proc_style
    [string]$proc_nowin

    dvlp_process_same([string]$proc_cmd) : base($proc_cmd){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    re_set () {
        $this.proc_nowin = 'nowin'
    }
}

class dvlp_process_popmin : dvlp_process {
    [String]$proc_exit
    [String]$proc_noexit
    [String]$proc_style

    dvlp_process_popmin([string]$proc_cmd) : base($proc_cmd){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_popmin([string]$proc_cmd, [string]$proc_wait) : base($proc_cmd, $proc_wait){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_popmin([string]$proc_cmd, [string]$proc_wait, [string]$proc_noexit) : base($proc_cmd, $proc_wait, $proc_noexit){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    re_set () {
        $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::Minimized
    }
}

class dvlp_process_pop : dvlp_process {
    [String]$proc_exit
    [String]$proc_noexit
    [String]$proc_style

    dvlp_process_pop([string]$proc_cmd) : base($proc_cmd){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_pop([string]$proc_cmd, [string]$proc_wait) : base($proc_cmd, $proc_wait){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    dvlp_process_pop([string]$proc_cmd, [string]$proc_wait, [string]$proc_noexit) : base($proc_cmd, $proc_wait, $proc_noexit){
        $this.re_set()
        ([dvlp_process] $this).start()
    }
    re_set () {
        $this.proc_style = [System.Diagnostics.ProcessWindowStyle]::Normal
    }
}

# [dvlp_process_quiet]::new("wsl_docker_full_restart;exit;", 'wait')::new('write-host "zzzzzzzzzz";start-sleep 2;', 'zdf')
function set_dvlp_env {
    param (
        $dvlp_env_var, $dvlp_env_val, $set_system_env
    )
    
    try {
        if (!([string]::IsNullOrEmpty($set_system_env) -or [string]::IsNullOrEmpty($set_system_env) -eq '0' -or [string]::IsNullOrEmpty($set_system_env) -eq 0)){
            [System.Environment]::SetEnvironmentVariable("$dvlp_env_var", "$dvlp_env_val")
        }
        if ([System.Environment]::GetEnvironmentVariable("$dvlp_env_var", [System.EnvironmentVariableTarget]::Machine) -ne "$dvlp_env_val"){
            $cmd_str = "[System.Environment]::SetEnvironmentVariable('$dvlp_env_var', '$dvlp_env_val', [System.EnvironmentVariableTarget]::Machine)"
            return $cmd_str
        }
        return $null
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host "error setting $dvlp_env_var"
            Write-Host "$cmd_str"
        }
        return $null
    }

}

function set_dvlp_envs_new_win {
    if ([string]::IsNullOrEmpty($env:KINDTEK_NEW_PROC_STYLE)) {
        $this_proc_style = [System.Diagnostics.ProcessWindowStyle]::Minimized
        $this_proc_style = "-WindowStyle $this_proc_style"
    }
    else {
        $this_proc_style = $env:KINDTEK_NEW_PROC_STYLE
    }
    [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("set_dvlp_envs;exit;", "wait")
}
function set_dvlp_envs {
    param (
        $DEBUG_MODE
    )
    $cmd_strs = New-Object System.Collections.ArrayList
    $repo_src_owner = 'kindtek'
    $repo_src_name = 'devels-workshop'
    $repo_dir_name = 'dvlw'
    $repo_src_branch = 'main'
    $repo_src_name2 = 'devels-playground'
    $repo_dir_name2 = 'dvlp'
    $repo_src_name3 = 'powerhell'
    $repo_dir_name3 = 'powerhell'
    $repo_src_name4 = 'dvl-adv'
    $repo_dir_name4 = 'dvl-adv'
    $repo_src_name5 = 'kernels'
    $repo_dir_name5 = 'kernels'
    $repo_src_name6 = 'mnt'
    $repo_dir_name6 = 'mnt'
    $git_parent_path = "$env:USERPROFILE/repos/$repo_src_owner"
    $git_path = "$git_parent_path/$repo_dir_name"
    # . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1


    if ($env:KINDTEK_WIN_GIT_OWNER -ne "$repo_src_owner" -or $env:KINDTEK_WIN_GIT_OWNER -ne "$repo_src_owner") {
        write-host "setting global environment variables ..."
        start-sleep 3
    }
    try {
        if ([string]::IsNullOrEmpty($DEBUG_MODE) -or $DEBUG_MODE -eq '0') {
            Set-PSDebug -Trace 0;
            $cmd_str = set_dvlp_env 'KINDTEK_DEBUG_MODE' '0'
            if ($null -ne $cmd_str){
                $cmd_strs.Add($cmd_str) > $null
            }
            $cmd_str = set_dvlp_env 'KINDTEK_NEW_PROC_NOEXIT' " "
            if ($null -ne $cmd_str){
                $cmd_strs.Add($cmd_str) > $null
            }
        }
        elseif (!([string]::IsNullOrEmpty($DEBUG_MODE)) -and $DEBUG_MODE -ne '0') {
            Set-PSDebug -Trace 2;
            $this_proc_style = [System.Diagnostics.ProcessWindowStyle]::Normal;
            $cmd_str = set_dvlp_env 'KINDTEK_NEW_PROC_STYLE' "$this_proc_style"
            if ($null -ne $cmd_str){
                $cmd_strs.Add($cmd_str) > $null
            }
            $cmd_str = set_dvlp_env 'KINDTEK_NEW_PROC_STYLE' "-noexit"
            if ($null -ne $cmd_str){
                $cmd_strs.Add($cmd_str) > $null
            }
            $cmd_str = set_dvlp_env 'KINDTEK_NEW_PROC_NOEXIT' "-noexit"
            if ($null -ne $cmd_str){
                $cmd_strs.Add($cmd_str) > $null
            }
            Write-Output "debug = true"
        }
        if ($DEBUG_MODE -ne '0') {        
            Write-Host "debug mode set to $env:KINDTEK_DEBUG_MODE"
            Write-Host "$cmd_str_dbg"
        }
        else {
            Write-Host "debug mode not set"
            Write-Host "$cmd_str_dbg"
        }
    }
    catch {
        Write-Host 'error setting debug mode.'
        Write-Host "$cmd_str_dbg"
    }
    # }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_FAILSAFE_WSL_DISTRO' "kalilinux-kali-rolling-latest"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:$env:KINDTEK_FAILSAFE_WSL_DISTRO -Value 'kalilinux-kali-rolling-latest' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {        
            Write-Host 'error setting KINDTEK_FAILSAFE_WSL_DISTRO'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_DEFAULT_WSL_DISTRO' "kalilinux-kali-rolling-latest"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:$env:KINDTEK_FAILSAFE_WSL_DISTRO -Value 'kalilinux-kali-rolling-latest' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {        
            Write-Host 'error setting KINDTEK_FAILSAFE_WSL_DISTRO'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_DEVEL_TOOLS' "$git_parent_path/scripts/devel-tools.ps1"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:$env:KINDTEK_FAILSAFE_WSL_DISTRO -Value 'kalilinux-kali-rolling-latest' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE)) -and ([string]::IsNullOrEmpty($env:KINDTEK_DEVEL_TOOLS))) {
            Write-Host 'error setting KINDTEK_DEVEL_TOOLS'
            Write-Host "$cmd_str"
        }
    }    
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_GIT_OWNER' "$repo_src_owner"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_GIT_OWNER -Value  $repo_src_owner -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_GIT_OWNER'
            Write-Host "$cmd_str"
        }
    }
    try { 
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_GIT_PATH' "$git_parent_path"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_GIT_PATH -Value $git_parent_path -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_GIT_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLW_PATH' "$git_path"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLW_PATH -Value $git_path -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLW_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLW_FULLNAME' "$repo_src_name"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLW_FULLNAME -Value $repo_src_name -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLW_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLW_NAME' "$repo_dir_name"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLW_NAME -Value $repo_dir_name -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLW_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {            
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLW_BRANCH' "$repo_src_branch"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLW_BRANCH -Value $repo_src_branch -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLW_BRANCH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLP_PATH' "$git_path/$repo_dir_name2"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLP_PATH -Value '$git_path/$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLP_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {            
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLP_FULLNAME' "$repo_src_name2"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLP_FULLNAME -Value $repo_src_name2 -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLP_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLP_NAME' "$repo_dir_name2"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLP_NAME -Value $repo_dir_name2 -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLP_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_POWERHELL_FULLNAME' "$repo_dir_name3"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_POWERHELL_PATH -Value '$git_path/$repo_dir_name3' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_POWERHELL_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_POWERHELL_NAME' "$repo_dir_name3"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        KINDTEK_WIN_POWERHELL_FULLNAME
        # Set-Item -Path env:KINDTEK_WIN_POWERHELL_PATH -Value '$git_path/$repo_dir_name3' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_POWERHELL_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_POWERHELL_PATH' "$git_path/$repo_dir_name3"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_POWERHELL_PATH'
            Write-Host "$cmd_str"
        }
        # Set-Item -Path env:KINDTEK_WIN_POWERHELL_PATH -Value "$git_path/$repo_dir_name3" -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_POWERHELL_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLADV_FULLNAME' "$repo_dir_name4"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLADV_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLADV_NAME' "$repo_dir_name4"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLADV_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_DVLADV_PATH' "$git_path/$repo_dir_name4"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_DVLADV_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_KERNELS_FULLNAME' "$repo_dir_name5"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_KERNELS_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_KERNELS_NAME' "$repo_dir_name5"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_KERNELS_PATH'
            Write-Host "$cmd_str"
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_KERNELS_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_KERNELS_PATH' "$repo_dir_name5"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_KERNELS_PATH'
            Write-Host "$cmd_str"
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_KERNELS_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_MNT_FULLNAME' "$repo_dir_name6"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_MNT_FULLNAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_MNT_NAME' "$repo_dir_name6"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_MNT_NAME'
            Write-Host "$cmd_str"
        }
        # Set-Item -Path env:KINDTEK_WIN_DVLADV_PATH -Value '$repo_dir_name2' -Force
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_MNT_NAME'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'KINDTEK_WIN_MNT_PATH' "$git_path/$repo_dir_name6"
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting KINDTEK_WIN_MNT_PATH'
            Write-Host "$cmd_str"
        }
    }
    try {
        $cmd_str = set_dvlp_env 'WSL_UTF8' '1'
        if ($null -ne $cmd_str){
            $cmd_strs.Add($cmd_str) > $null
        }
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting WSL_UTF8'
            Write-Host "$cmd_str"
        }
    }
    catch {
        if (!([string]::IsNullOrEmpty($DEBUG_MODE))) {
            Write-Host 'error setting WSL_UTF8'
            Write-Host "$cmd_str"
        }
    }
    foreach ($cmd in $cmd_strs) {
        echo "$cmd"
        [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("$cmd")
    }
    while ([string]::IsNullOrEmpty($env:KINDTEK_WIN_GIT_OWNER) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_DEBUG_MODE) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_DEVEL_TOOLS) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_FAILSAFE_WSL_DISTRO) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_GIT_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_GIT_OWNER) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_GIT_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLW_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLW_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLW_BRANCH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLW_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLP_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLP_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLP_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_POWERHELL_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_POWERHELL_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_POWERHELL_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLADV_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLADV_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_DVLADV_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_KERNELS_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_KERNELS_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_KERNELS_PATH) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_MNT_NAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_MNT_FULLNAME) `
            -or [string]::IsNullOrEmpty($env:KINDTEK_WIN_MNT_PATH) ) {
        echo 'waiting for environment variables to update'
        start-sleep 5

    }
    try {
        . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1
    }catch{}

}

function unset_dvlp_envs {
    if ( [string]::IsNullOrEmpty($env:KINDTEK_WIN_GIT_OWNER)) {
        $dvlp_owner = 'kindtek'
    }
    else {
        $dvlp_owner = $env:KINDTEK_WIN_GIT_OWNER
    }
    get-childitem env: | where-object name -match ("^" + [regex]::escape($dvlp_owner) + ".*$") | foreach-object {
        $unset_var = $_.name
        $unset_cmd_local = "[System.Environment]::SetEnvironmentVariable('$unset_var', '$null', [System.EnvironmentVariableTarget]::Machine)"
        [System.Environment]::SetEnvironmentVariable("$unset_var", "$null")
        [dvlp_process_quiet]$dvlp_proc_local_envs = [dvlp_process_quiet]::new("$unset_cmd_local;", 'wait')
        env_refresh
        # echo "unset:$unset_cmd_machine"
        # echo Start-Process -FilePath powershell.exe -LoadUserProfile -WindowStyle "$env:KINDTEK_NEW_PROC_STYLE" -ArgumentList "-noexit", "-Command $unset_cmd"
    }
    [Environment]::GetEnvironmentVariables('machine') | where-object name -match ("^" + [regex]::escape($dvlp_owner) + ".*$") | foreach-object {
        $unset_var = $_.name
        $unset_cmd_machine = "[System.Environment]::SetEnvironmentVariable('$unset_var', '$null', [System.EnvironmentVariableTarget]::Machine)"
        [dvlp_process_quiet]$dvlp_proc_machine_envs = [dvlp_process_quiet]::new("$unset_cmd_machine;", 'wait')
        env_refresh
        # echo "unset:$unset_cmd_machine"
        # echo Start-Process -FilePath powershell.exe -LoadUserProfile -WindowStyle "$env:KINDTEK_NEW_PROC_STYLE" -ArgumentList "-noexit", "-Command $unset_cmd"
    }
}

function test_wsl_distro {
    param (
        $distro_name
    )
    if ([string]::IsNullOrEmpty($distro_name)){
        return $false
    }
    Write-Host "testing wsl distro $distro_name"
    $test_string = 'helloworld'
    $test = wsl.exe -d $distro_name --exec echo $test_string
    if ($test -eq $test_string){
        # Write-Host "$distro_name is valid distro"
        return $true
    } else {
        # Write-Host "$distro_name is INVALID distro"
        return $false
    }
}

function test_default_wsl_distro {
    param (
        $distro_name
    )
    Write-Host "preparing to test wsl default distro $distro_name"

    if ( test_wsl_distro $distro_name){
        Write-Host "testing wsl default distro $distro_name"
        require_docker_online_new_win
        if ((get_default_wsl_distro -eq $distro_name) -and (is_docker_desktop_online -eq $true)){
            # Write-Host "$distro_name is valid default distro"
            return $true
        } else {
            # Write-Host "$distro_name is INVALID default distro"
        }
    }

    return $false
}

function get_default_wsl_distro {
    $default_wsl_distro = wsl.exe --list | Where-Object { $_ -and $_ -ne '' -and $_ -match '(.*)\(' }
    $default_wsl_distro = $default_wsl_distro -replace '^(.*)\s.*$', '$1'
    return $default_wsl_distro
}

function revert_default_wsl_distro {
    $env:KINDTEK_FAILSAFE_WSL_DISTRO = 'kalilinux-kali-rolling-latest'
    try {
        wsl.exe -s $env:KINDTEK_FAILSAFE_WSL_DISTRO
    }
    catch {
        try {
            run_devels_playground "default"
        }
        catch {
            Write-Host "error reverting to $env:KINDTEK_FAILSAFE_WSL_DISTRO as default wsl distro"
            return $false
        }
    }
    if ( test_default_wsl_distro $env:KINDTEK_FAILSAFE_WSL_DISTRO ) {
        return $true
    }
    else {
        return $false
    }
}
function set_default_wsl_distro {
    param (
        $new_wsl_default_distro
    )
    if ([string]::IsNullOrEmpty($new_wsl_default_distro)){
        if (!([string]::IsNullOrEmpty($env:KINDTEK_FAILSAFE_DISTRO))){
            $new_wsl_default_distro = $env:KINDTEK_FAILSAFE_DISTRO
        } else {
            return $false
        }
    }
    try {
        $old_wsl_default_distro = get_default_wsl_distro
        try {
            wsl.exe -s $new_wsl_default_distro
            cmd.exe /c net stop LxssManager
            cmd.exe /c net start LxssManager
        }
        catch {
            Write-Host "error changing wsl default distro from $old_wsl_default_distro to $new_wsl_default_distro"
            $new_wsl_default_distro = $env:KINDTEK_FAILSAFE_DISTRO
            Write-Host "restoring default distro as $old_wsl_default_distro"
            wsl.exe -s $old_wsl_default_distro
            cmd.exe /c net stop LxssManager
            cmd.exe /c net start LxssManager
            $new_wsl_default_distro = $old_wsl_default_distro
        }
        # handle failed installations
        if ( test_default_wsl_distro $new_wsl_default_distro -eq $false ) {
            Write-Host "ERROR: docker desktop failed to start with $new_wsl_default_distro as default"
            Start-Sleep 3
            Write-Host "reverting to $env:KINDTEK_FAILSAFE_DISTRO as default wsl distro ..."
            try {
                wsl.exe -s $env:KINDTEK_FAILSAFE_DISTRO
            }
            catch {
                try {
                    run_devels_playground "default"
                }
                catch {
                    Write-Host "error setting $env:KINDTEK_FAILSAFE_DISTRO as default wsl distro"
                }
            }
            # wsl_docker_restart
            wsl_docker_restart_new_win
            require_docker_online_new_win
            $env:OLD_DEFAULT_WSL_DISTRO = $old_wsl_default_distro
            return $false
        }
        else {
            return $true
        }
    }
    catch {
        return $false
    }
}
function install_winget {
    $software_name = "WinGet"
    Write-Host "`r`n"
    if (!(Test-Path -Path "$env:KINDTEK_WIN_GIT_PATH/.winget-installed" -PathType Leaf)) {
        $file = "$env:KINDTEK_WIN_GIT_PATH/get-latest-winget.ps1"
        Write-Host "Installing $software_name ..." -ForegroundColor DarkCyan
        Invoke-WebRequest "https://raw.githubusercontent.com/kindtek/dvl-adv/dvl-works/get-latest-winget.ps1" -OutFile $file;
        [dvlp_process_pop]$dvlp_proc = [dvlp_process_pop]::new("powershell.exe -executionpolicy remotesigned -File $file", 'wait')
        # install winget and use winget to install everything else
        # $p = Get-Process -Name "PackageManagement"
        # Stop-Process -InputObject $p
        # Get-Process | Where-Object { $_.HasExited }
        Write-Host "$software_name installed" -ForegroundColor DarkCyan | Out-File -FilePath "$env:KINDTEK_WIN_GIT_PATH/.winget-installed"
    }
    else {
        Write-Host "$software_name already installed" -ForegroundColor DarkCyan
    }
}

function install_git {
    $software_name = "Github CLI"
    $refresh_envs = "$env:KINDTEK_WIN_GIT_PATH/RefreshEnv.cmd"
    $global:progress_flag = 'silentlyContinue'
    $orig_progress_flag = $progress_flag 
    $progress_flag = 'SilentlyContinue'
    Invoke-WebRequest "https://raw.githubusercontent.com/kindtek/choco/ac806ee5ce03dea28f01c81f88c30c17726cb3e9/src/chocolatey.resources/redirects/RefreshEnv.cmd" -OutFile $refresh_envs | Out-Null
    $progress_flag = $orig_progress_flag
    if (!(Test-Path -Path "$env:KINDTEK_WIN_GIT_PATH/.github-installed" -PathType Leaf)) {
        Write-Host "Installing $software_name ..." -ForegroundColor DarkCyan
        [dvlp_process_pop]$dvlp_proc_git = [dvlp_process_pop]::new("winget install --exact --id GitHub.cli --silent --locale en-US --accept-package-agreements --accept-source-agreements;winget upgrade --exact --id GitHub.cli --silent --locale en-US --accept-package-agreements --accept-source-agreements;winget install --id Git.Git --source winget --silent --locale en-US --accept-package-agreements --accept-source-agreements;winget upgrade --id Git.Git --source winget --silent --locale en-US --accept-package-agreements --accept-source-agreements;exit;", 'wait')
        Write-Host "$software_name installed" -ForegroundColor DarkCyan | Out-File -FilePath "$env:KINDTEK_WIN_GIT_PATH/.github-installed"; `
    }
    else {
        Write-Host "$software_name already installed" -ForegroundColor DarkCyan
    }
    # allow git to be used in same window immediately after installation
    powershell.exe -Command $refresh_envs | Out-Null
    ([void]( New-Item -path alias:git -Value 'C:\Program Files\Git\bin\git.exe' -ErrorAction SilentlyContinue | Out-Null ))
    [dvlp_process_pop]$dvlp_proc_sync = [dvlp_process_pop]::new("sync_repo;exit;", 'wait')
    # assuming the repos are now synced now is a good time to dot source devel-tools
    . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1
    # Start-Process powershell -LoadUserProfile $env:KINDTEK_NEW_PROC_STYLE -ArgumentList [string]$env:KINDTEK_NEW_PROC_NOEXIT "-Command &{sync_repo;exit;}" -Wait
    return $new_install
}

function sync_repo {

    Write-Host "testing git command ..." -ForegroundColor DarkCyan
    ([void]( New-Item -path alias:git -Value 'C:\Program Files\Git\bin\git.exe' -ErrorAction SilentlyContinue | Out-Null ))
    Write-Host "synchronizing kindtek github repos ..." -ForegroundColor DarkCyan
    Push-Location $env:KINDTEK_WIN_GIT_PATH
    Write-Host "synchronizing $env:KINDTEK_WIN_GIT_PATH/$env:KINDTEK_WIN_DVLW_NAME with https://github.com/$env:KINDTEK_WIN_GIT_OWNER/$env:KINDTEK_WIN_DVLW_FULLNAME repo ..." -ForegroundColor DarkCyan
    try {
        git -C $env:KINDTEK_WIN_DVLW_NAME pull --progress
        write-host "$env:KINDTEK_WIN_DVLW_NAME pulled"
    }
    catch {
        try {
            git clone "https://github.com/$env:KINDTEK_WIN_GIT_OWNER/$env:KINDTEK_WIN_DVLW_FULLNAME" --branch $env:KINDTEK_WIN_DVLW_BRANCH --progress -- $env:KINDTEK_WIN_DVLW_NAME
            write-host "$env:KINDTEK_WIN_DVLW_NAME cloned"
        }
        catch {}
    }
    Push-Location $env:KINDTEK_WIN_DVLW_NAME
    try {
        git submodule update --remote --progress -- $env:KINDTEK_WIN_DVLP_NAME
        write-host "$env:KINDTEK_WIN_DVLP_NAME pulled"
        git submodule update --remote --progress -- $env:KINDTEK_WIN_DVLADV_NAME
        write-host "$env:KINDTEK_WIN_DVLADV_NAME pulled"
        git submodule update --remote --progress -- $env:KINDTEK_WIN_POWERHELL_NAME
        write-host "$env:KINDTEK_WIN_POWERHELL_NAME pulled"
    }
    catch {
        try {
            git submodule update --init --init --remote --progress -- $env:KINDTEK_WIN_DVLP_NAME
            write-host "$env:KINDTEK_WIN_DVLP_NAME pulled"
            git submodule update --init --remote --progress -- $env:KINDTEK_WIN_DVLADV_NAME
            write-host "$env:KINDTEK_WIN_DVLADV_NAME pulled"
            git submodule update --init --remote --progress -- $env:KINDTEK_WIN_POWERHELL_NAME
            write-host "$env:KINDTEK_WIN_POWERHELL_NAME pulled"
        }
        catch {}
    }
    Push-Location $env:KINDTEK_WIN_DVLP_NAME
    try {
        git submodule update --remote --progress -- $env:KINDTEK_WIN_MNT_NAME
        write-host "$env:KINDTEK_WIN_MNT_NAME pulled"
        git submodule update --remote --progress -- $env:KINDTEK_WIN_KERNELS_NAME
        write-host "$env:KINDTEK_WIN_KERNELS_NAME pulled"
    }
    catch {
        try {
            git submodule update --init --remote --progress -- $env:KINDTEK_WIN_MNT_NAME
            write-host "$env:KINDTEK_WIN_MNT_NAME pulled"
            git submodule update --init --remote --progress -- $env:KINDTEK_WIN_KERNELS_NAME
            write-host "$env:KINDTEK_WIN_KERNELS_NAME pulled"
        }
        catch {}
    }
    Pop-Location
    Pop-Location
    Pop-Location
}

function run_devels_playground {
    param (
        $img_name_tag, $non_interactive, $default_distro
    )
    try {
        $software_name = "docker devel"
        # if (!(Test-Path -Path "$env:KINDTEK_WIN_GIT_PATH/.dvlp-installed" -PathType Leaf)) {
        Write-Host "establishing a connection with docker desktop ...`r`n" 
        Write-Host "`r`nIMPORTANT: keep docker desktop running or the import will fail`r`n" 
        require_docker_online_new_win
        if (is_docker_desktop_online -eq $true) {
            Write-Host "now connected to docker desktop ...`r`n"
            # Write-Host "&$devs_playground $env:img_name_tag"
            # Write-Host "$([char]27)[2J"
            # Write-Host "`r`npowershell.exe -Command `"$env:"$env:KINDTEK_WIN_DVLP_PATH/scripts/wsl-docker-import.cmd`" $img_name_tag`r`n"
            $img_name_tag = $img_name_tag.replace("\s+", '')
            # write-host `$img_name_tag $img_name_tag
            # write-host `$non_interactive $non_interactive
            # write-host `$default_distro $default_distro
            # $current_process = [System.Diagnostics.Process]::GetCurrentProcess() | Select-Object -ExpandProperty ID
            # $current_process_object = Get-Process -id $current_process
            # Set-ForegroundWindow $current_process_object.MainWindowHandle
            # Set-ForegroundWindow ($current_process_object).MainWindowHandle
            if ([string]::IsNullOrEmpty($img_name_tag)){
                powershell.exe -Command "$env:KINDTEK_WIN_DVLP_PATH/scripts/wsl-docker-import.cmd"
            } else {
                powershell.exe -Command "$env:KINDTEK_WIN_DVLP_PATH/scripts/wsl-docker-import.cmd '$img_name_tag' '$non_interactive' '$default_distro', 'wait'"
            }

            # powershell.exe -Command "$env:KINDTEK_WIN_DVLP_PATH/scripts/wsl-docker-import.cmd" "$img_name_tag" "$non_interactive" "$default_distro"
            # &$devs_playground = "$env:KINDTEK_WIN_GIT_PATH/dvlp/scripts/wsl-docker-import.cmd $env:img_tag"
        }
        else {
            Write-Host "`r`nmake sure docker desktop is running"
            Write-Host "still not working? try: `r`n`t- restart WSL`r`n`t- change your default distro (ie: wsl.exe -s kalilinux-kali-rolling-latest )"
        }
        
        # }
    }
    catch {}
}

function run_dvlp_latest_kernel_installer {
    param (
        $distro
    )
    push-location $env:KINDTEK_WIN_DVLP_PATH/kernels/linux/kache
    require_docker_online_new_win
    if (is_docker_desktop_online -eq $true){
        ./wsl-kernel-install.ps1 latest
    }    
    pop-location
}

function install_everything {  
    param (
        $img_tag
    )
    $dvlp_choice = 'n'
    do {
        . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1
        $host.UI.RawUI.ForegroundColor = "Black"
        $host.UI.RawUI.BackgroundColor = "White"
        $img_name = $env:KINDTEK_WIN_DVLP_FULLNAME
        $img_name_tag = "$img_name`:$img_tag"
        $confirmation = ''
    
        if (($dvlp_choice -ine 'kw') -And (!(Test-Path -Path "$env:KINDTEK_WIN_DVLW_PATH/.dvlp-installed" -PathType Leaf))) {
            $host.UI.RawUI.ForegroundColor = "Black"
            $host.UI.RawUI.BackgroundColor = "DarkRed"
            Write-Host "$([char]27)[2J"
            # $confirmation = Read-Host "`r`nRestarts may be required as new applications are installed. Save your work now.`r`n`r`n`tHit ENTER to continue`r`n`r`n`tpowershell.exe -Command $file $args" 
            Write-Host "`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n"
            $confirmation = Read-Host "Restarts may be required as new applications are installed. Save your work now.`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`tHit ENTER to continue`r`n"
            Write-Host "$([char]27)[2J"
            Write-Host "`r`n`r`n`r`n`r`n`r`n`r`nRestarts may be required as new applications are installed. Save your work now.`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`r`n`t"
    
        }
        if ($confirmation -eq '') {
            # source of the below self-elevating script: https://blog.expta.com/2017/03/how-to-self-elevate-powershell-script.html#:~:text=If%20User%20Account%20Control%20(UAC,select%20%22Run%20with%20PowerShell%22.
            # Self-elevate the script if required
            if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
                if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
                    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
                    Start-Process -FilePath PowerShell.exe -Verb Runas -WindowStyle Maximized -ArgumentList $CommandLine
                    Exit
                }
            }
            # img_tag must not empty ... OR dvlp must not installed
            if (!(Test-Path -Path "$env:KINDTEK_WIN_DVLW_PATH/.dvlp-installed" -PathType Leaf) -or (!([string]::IsNullOrEmpty($img_tag)))) {
                Write-Host "`t-- use CTRL + C or close this window to cancel anytime --"
                Start-Sleep 3
                Write-Host ""
                Start-Sleep 1
                Write-Host ""
                Write-Host ""
                Start-Sleep 1
                Write-Host ""
                Start-Sleep 1
                $host.UI.RawUI.BackgroundColor = "Black"
                Write-Host "`r`n`r`nThese programs will be installed or updated:" -ForegroundColor Magenta
                Start-Sleep 1
                Write-Host "`r`n`t- WinGet`r`n`t- Github CLI`r`n`t- devels-workshop repo`r`n`t- devels-playground repo" -ForegroundColor Magenta
                
                # Write-Host "Creating path $env:USERPROFILE\repos\kindtek if it does not exist ... "  
                New-Item -ItemType Directory -Force -Path $env:KINDTEK_WIN_GIT_PATH | Out-Null
        
                install_winget $env:KINDTEK_WIN_GIT_PATH
                install_git
                . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1
                run_installer
                # $host.UI.RawUI.ForegroundColor = "DarkGray"
                # $host.UI.RawUI.ForegroundColor = "White"
                require_docker_online_new_win
                # make sure failsafe kalilinux-kali-rolling-latest distro is installed so changes can be easily reverted
                # $env:KINDTEK_WIN_DVLW_PATH, $img_name_tag, $non_interactive, $default_distro
                try {
                    if (!(Test-Path -Path "$env:KINDTEK_WIN_DVLW_PATH/.dvlp-installed" -PathType Leaf)) {
                        run_devels_playground "default"
                        cmd.exe /c net stop LxssManager
                        cmd.exe /c net start LxssManager
                        # write-host "testing wsl distro $env:KINDTEK_FAILSAFE_WSL_DISTRO"
                        if ((test_default_wsl_distro $env:KINDTEK_FAILSAFE_WSL_DISTRO) -eq $true){
                            # write-host "$env:KINDTEK_FAILSAFE_WSL_DISTRO test passed"
                            Write-Host "docker devel installed`r`n" | Out-File -FilePath "$env:KINDTEK_WIN_DVLW_PATH/.dvlp-installed"
                        } else {
                            # write-host "$env:KINDTEK_FAILSAFE_WSL_DISTRO test FAILED"
                        }
                        # install hypervm on next open
                        try {
                            if (!(Test-Path "$env:KINDTEK_WIN_DVLW_PATH/.hypervm-installed" -PathType Leaf)) {
                                $profilePath = Join-Path $env:USERPROFILE 'Documents\PowerShell\Microsoft.PowerShell_profile.ps1'
                                $vmpPath = Join-Path $env:USERPROFILE 'Documents\PowerShell\kindtek.Set-VMP.ps1'
                                New-Item -Path $profilePath -ItemType File -Force
                                New-Item -Path $vmpPath -ItemType File -Force
                                Add-Content $profilePath "./kindtek.Set-VMP.ps1;Clear-Content 'kindtek.Set-VMP.ps1';./$env:USERPROFILE/dvlp"
                                Add-Content $vmpPath "`nWrite-Host 'Preparing to set up HyperV VM Processor as kali-linux ...';Start-Sleep 10;Set-VMProcessor -VMName kali-linux -ExposeVirtualizationExtensions `$true -ErrorAction SilentlyContinue"        
                                Write-Host "$software_name installed`r`n" | Out-File -FilePath "$env:KINDTEK_WIN_DVLW_PATH/.hypervm-installed"
                            }
                        }
                        catch {}
                    }
                    
                }
                catch {
                    Write-Host "error setting $env:KINDTEK_FAILSAFE_WSL_DISTRO as default wsl distro"
                }
                # install distro requested in arg
                try {
                    if (!([string]::IsNullOrEmpty($img_tag))) {
                        $host.UI.RawUI.ForegroundColor = "Black"
                        $host.UI.RawUI.BackgroundColor = "White"

                        $old_wsl_default_distro = get_default_wsl_distro
                        run_devels_playground "$img_name_tag" "kindtek-$img_name_tag" "default"
                        $new_wsl_default_distro = get_default_wsl_distro
                        cmd.exe /c net stop LxssManager
                        cmd.exe /c net start LxssManager
                        run_dvlp_latest_kernel_installer
                        require_docker_online_new_win
                        if (($new_wsl_default_distro -ne $old_wsl_default_distro) -and (is_docker_desktop_online -eq $false)) {
                            Write-Host "ERROR: docker desktop failed to start with $new_wsl_default_distro distro"
                            Write-Host "reverting to $old_wsl_default_distro as default wsl distro ..."
                            try {
                                wsl.exe -s $old_wsl_default_distro
                                wsl_docker_restart_new_win
                                # wsl_docker_restart
                                require_docker_online_new_win
                            }
                            catch {
                                try {
                                    revert_default_wsl_distro
                                    require_docker_online_new_win
                                }
                                catch {
                                    Write-Host "error setting failsafe as default wsl distro"
                                }
                            }
                        }
                    }
                }
                catch {
                    Write-Host "error setting "kindtek-$img_name_tag" as default wsl distro"
                    try {
                        wsl.exe -s $env:KINDTEK_FAILSAFE_WSL_DISTRO
                        require_docker_online_new_win
                    }
                    catch {
                        try {
                            revert_default_wsl_distro
                            require_docker_online_new_win
                        }
                        catch {
                            Write-Host "error setting failsafe as default wsl distro"
                        }
                    }
                }
            } else {
                . $env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1
                [dvlp_process_popmax]$dvlp_proc = [dvlp_process_popmax]::new("install_git;run_installer;")
            } 
            do {
                $wsl_restart_path = "$env:USERPROFILE/wsl-restart.ps1"
                $env:DEFAULT_WSL_DISTRO = get_default_wsl_distro
                if ([string]::IsNullOrEmpty($env:OLD_DEFAULT_WSL_DISTRO)) {
                    $env:OLD_DEFAULT_WSL_DISTRO = $env:KINDTEK_FAILSAFE_WSL_DISTRO
                    $wsl_distro_undo_option = "`r`n`t- [u]ndo wsl changes (reset to $env:OLD_DEFAULT_WSL_DISTRO)"
                }
                elseif ("$env:OLD_DEFAULT_WSL_DISTRO" -ne "$env:DEFAULT_WSL_DISTRO") {
                    $wsl_distro_undo_option = "`r`n`t- [u]ndo wsl changes (revert to $env:OLD_DEFAULT_WSL_DISTRO)"
                }
                else {
                    $wsl_distro_undo_option = ''
                }
                # if (get_default_wsl_distro -eq $env:KINDTEK_FAILSAFE_WSL_DISTRO){
                #     $wsl_distro_undo_option = "`r`n`t- set [f]ailsafe distro as default" + $wsl_distro_undo_option
                # }
                $restart_option = "`r`n`t- [r]estart"
                # $dvlp_choice = Read-Host "`r`nHit ENTER to exit or choose from the following:`r`n`t- launch [W]SL`r`n`t- launch [D]evels Playground`r`n`t- launch repo in [V]S Code`r`n`t- build/install a Linux [K]ernel`r`n`r`n`t"
                $dvlp_options = "`r`n`r`n`r`nChoose from the following:`r`n`t- [d]ocker devel$wsl_distro_undo_option`r`n`t- [c]ommand line`r`n`t- [k]indtek setup$restart_option`r`n`r`n`r`n(exit)"
                # $current_process = [System.Diagnostics.Process]::GetCurrentProcess() | Select-Object -ExpandProperty ID
                # $current_process_object = Get-Process -id $current_process
                # Set-ForegroundWindow $current_process_object.MainWindowHandle
                $dvlp_choice = Read-Host $dvlp_options
                if ($dvlp_choice -ieq 'f') {
                    try {
                        set_default_wsl_distro
                        require_docker_online_new_win
                    }
                    catch {
                        try {
                            revert_default_wsl_distro
                        }
                        catch {
                            Write-Host "error setting $env:KINDTEK_FAILSAFE_WSL_DISTRO as default wsl distro"
                        }
                    }
                }
                elseif ($dvlp_choice -like 'c**') {    
                    if ($dvlp_choice -ieq 'c') {
                        Write-Host "`r`n`t[l]inux or [w]indows"
                        $dvlp_cli_options = Read-Host
                    }
                    if ($dvlp_cli_options -ieq 'l' -or $dvlp_cli_options -ieq 'w') {
                        $dvlp_choice = $dvlp_choice + $dvlp_cli_options
                    }
                    if ($dvlp_choice -ieq 'cl' ) {
                        wsl.exe --cd /hal
                    }
                    elseif ($dvlp_choice -ieq 'cdl' ) {
                        wsl.exe --cd /hal --exec cdir
                    }
                    elseif ($dvlp_choice -ieq 'cw' ) {
                        [dvlp_process_popmax]$dvlp_proc = [dvlp_process_popmax]::new("Set-Location -literalPath $env:USERPROFILE", '', 'noexit')
                    }
                    elseif ($dvlp_choice -ieq 'cdw' ) {
                        # one day might get the windows cdir working
                        [dvlp_process_popmax]$dvlp_proc = [dvlp_process_popmax]::new("Set-Location -literalPath $env:USERPROFILE", '', 'noexit')
                    }
                }
                elseif ($dvlp_choice -ieq 'd') {
                    require_docker_online_new_win
                    if ([string]::IsNullOrEmpty($img_name_tag)){
                        run_devels_playground
                    } else {
                        run_devels_playground "$img_name_tag" 
                    }
                }
                elseif ($dvlp_choice -ieq 'd!') {
                    require_docker_online_new_win
                    run_devels_playground "$img_name_tag" "kindtek-$img_name_tag" "default"
                }
                elseif ($dvlp_choice -like 'k*') {
                    if ($dvlp_choice -ieq 'k') {
                        Write-Host "`r`n`t[l]inux or [w]indows"
                        $dvlp_kindtek_options = Read-Host
                        if ($dvlp_kindtek_options -ieq 'l' -or $dvlp_kindtek_options -ieq 'w') {
                            $dvlp_choice = $dvlp_choice + $dvlp_kindtek_options
                        }
                    }
                    if ($dvlp_choice -ieq 'kl' ) {
                        wsl.exe --cd /hal exec bash setup.sh $env:USERNAME
                    }
                    elseif ($dvlp_choice -ieq 'kw' ) {
                        Write-Host 'checking for new updates ...'
                    }
                }
                elseif ($dvlp_choice -ieq 'u') {
                    if ($env:OLD_DEFAULT_WSL_DISTRO -ne "") {
                        # wsl.exe --set-default kalilinux-kali-rolling-latest
                        Write-Host "`r`n`r`nsetting $env:OLD_DEFAULT_WSL_DISTRO as default distro ..."
                        wsl.exe --set-default $env:OLD_DEFAULT_WSL_DISTRO
                        # wsl_docker_restart
                        wsl_docker_restart_new_win
                        require_docker_online_new_win
                    }
                }
                elseif ($dvlp_choice -ceq 'r') {
                    # wsl_docker_restart
                    wsl_docker_restart_new_win
                    require_docker_online_new_win
                }
                elseif ($dvlp_choice -ceq 'R') {
                    if (Test-Path $wsl_restart_path -PathType Leaf -ErrorAction SilentlyContinue ) {
                        powershell.exe -ExecutionPolicy RemoteSigned -File $wsl_restart_path
                        require_docker_online_new_win
                    }
                }
                elseif ($dvlp_choice -ceq 'R!') {
                    reboot_prompt
                    # elseif ($dvlp_choice -ieq 'v') {
                    #     wsl sh -c "cd /hel;. code"
                }
                else {
                    $dvlp_choice = ''
                }
            } while ($dvlp_choice -ne 'kw' -And $dvlp_choice -ne '')
        }
    } while ($dvlp_choice -ieq 'kw')
    
    
    Write-Host "`r`nGoodbye!`r`n"
}


if (!([string]::IsNullOrEmpty($args[0])) -or $PSCommandPath -eq "$env:USERPROFILE\dvlp.ps1") {

    try {
        $local_paths = [string][System.Environment]::GetEnvironmentVariable('path')
        $machine_paths = [string][System.Environment]::GetEnvironmentVariable('path', [System.EnvironmentVariableTarget]::Machine)
        $local_ext = [System.Environment]::GetEnvironmentVariable('pathext')
        $machine_ext = [string][System.Environment]::GetEnvironmentVariable('pathext', [System.EnvironmentVariableTarget]::Machine)
        
        if ($local_ext -split ";" -notcontains ".ps1") {
            $local_ext += ";.ps1"
            $cmd_str_local = "[System.Environment]::SetEnvironmentVariable('pathext', '$local_ext')"
            [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("$cmd_str_local", 'wait')
        }
        if ($machine_ext -split ";" -notcontains ".ps1") {
            $machine_ext += ";.ps1"
            $cmd_str_machine = "[System.Environment]::SetEnvironmentVariable('pathext', '$machine_ext', [System.EnvironmentVariableTarget]::Machine)"
            [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("$cmd_str_machine", 'wait')
        }
        if ($local_paths -split ";" -notcontains "$env:USERPROFILE\dvlp.ps1" -and $local_paths -split ";" -notcontains "$env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1") {
            $local_paths += ";$env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1"
            $cmd_str_local = "[System.Environment]::SetEnvironmentVariable('path', '$local_paths')"
            [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("$cmd_str_local", 'wait')
        }
        if ($machine_paths -split ";" -notcontains "$env:USERPROFILE\dvlp.ps1" -and $local_paths -split ";" -notcontains "$env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1") {
            $machine_paths += ";$env:KINDTEK_WIN_DVLW_PATH/scripts/devel-tools.ps1"
            $cmd_str_machine = "[System.Environment]::SetEnvironmentVariable('path', '$machine_paths', [System.EnvironmentVariableTarget]::Machine)"
            [dvlp_process_popmin]$dvlp_proc = [dvlp_process_popmin]::new("$cmd_str_machine", 'wait')
        }
    } catch {}
    set_dvlp_envs
    install_everything $args[0]
}
