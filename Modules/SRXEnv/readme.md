# SRXEnv

## Release Notes

### v1.0.3 - 02/11/2020

- Add new keys introduced with ScriptRunner 2019 R3
  - `ResultHtml` - assign HTML, that  for example can be retrieved via the ScriptRunner Apps and WebApps.
  - `SRXDisplayName` - the name of the current action.
- The authenticode issuer changed from `CN=AppSphere AG, OU=Software Products, O=AppSphere AG, L=Ettlingen, S=Baden-Wuerttemberg, C=DE` to
`CN=ScriptRunner Software GmbH, OU=Development, O=ScriptRunner Software GmbH, L=Ettlingen, C=DE`. Please use the `-SkipPublisherCheck` parameter to update the module.

### v1.0.2 - 08/14/2019

- Add Alias `Reset-SRXEnv`.

### v1.0.1 - 07/18/2019

- Fix broken signature.

### v1.0.0 - 07/17/2019

- Initial release.
