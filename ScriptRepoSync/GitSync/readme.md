# Sync Git repositories to ScriptRunner

You can use the [Invoke-GitSparseCheckout.ps1](./Invoke-GitSparseCheckout.ps1) script to clone a Git repository to the ScriptRunner Library or pull updates to a local repository.

The script requires [Git for Windows](https://git-for-windows.github.io). You can download this tool from [GitHub](https://github.com/git-for-windows/git/releases).

## Script Parameters

- GitRepoUrl

    URL of the git repository. e.g. `https://github.com/ScriptRunner/ActionPacks.git`

- GitUserCredential

    PSCredential of a git user, who is authorized to access the given git repository. Note that an email address is not a valid account name. You must use this ParameterSet for private repositories.

- SparseDirs

    Specify the list of subfolders you want to check out. If empty, all files will be checked out.
    Example: `"ActiveDirectory/*", "O365/*"`

- Branch

    The remote branch to check out.
    Default: `master`.

- SRLibraryPath

    Path to the ScriptRunner Library Path.
    Default: `C:\ProgramData\AppSphere\ScriptMgr`

- GitExePath

    Path to the git execuatble.
    Default: `C:\Program Files\Git\cmd\git.exe`.

- Cleanup

    Cleanup the local repository before initialize a new repository.
    All files and sub directories in the repository path will be removed.
    Default: `false`.
    
- CreateRepositoryFolder

    Creates a folder with the repository name in the storage path, if not available. 
    Otherwise, the system synchronizes directly to the storage path.
    Default value is 'true'    
    
- RemoveGitFolder

    Deletes the hidden folder .git and .github from the storage path, after synchronization
    Default value is 'false'.    

## How-To create a ScriptRunner Action

- Install `Git for Windows` at the ScriptRunner service host.
- Download the [Invoke-GitSparseCheckout.ps1](./Invoke-GitSparseCheckout.ps1) script to the ScriptRunner script repository. The default location of the ScriptRunner script repository is `C:\ProgramData\AppSphere\ScriptMgr`.
- Use the ScriptRunner Admin App to
  - create a Credential with UserName and Password for authenthication at the git server, if you want to clone a private git repository. A credential is not required, if you want to clone a public repository.
- create a new `Action` with the [Invoke-GitSparseCheckout.ps1](./Invoke-GitSparseCheckout.ps1) script.
  - select the target `Direct Service Execution` in the new `Action` wizard.
  - set the required script parameters to `Cannot be changed at script runtime` to enable scheduling for the `Action`.
  - example for the assignment of action parameters:

    ![How-To set Action parameters](./images/Invoke-GitSync_ActionParameters.png)

## Links

[ScriptRunner Action Packs](https://www.scriptrunner.com/action-packs)

[Git for Windows](https://git-for-windows.github.io)

[Git for Windows Releases](https://github.com/git-for-windows/git/releases)

[Git Credential Manager for Windows](https://github.com/Microsoft/Git-Credential-Manager-for-Windows)
