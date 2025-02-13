# ProTanki Utilities

A bunch of utilities for ProTanki.

## [Patch-Library-LegacySocket.ps1](Patch-Library-LegacySocket.ps1)

PowerShell script that patches `library.swf` (`http://s2.protanki-online.com/library.swf`) to use game and resource server configuration from `Prelauncher.swf`.  
Requires [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler) to be installed.  
The minimum supported game version is `library-20220501-221826`.

| Argument         | Type      | Description                                                      | Default value                            |
|------------------|-----------|------------------------------------------------------------------|------------------------------------------|
| `InputFile`      | `string`  | Game SWF to patch                                                |                                          |
| `OutputFile`     | `string`  | Patched SWF file                                                 |                                          |
| `FFDec`          | `string`  | Path to `ffdec.jar` file                                         | `C:\Program Files (x86)\FFDec\ffdec.jar` |

Example usage (PowerShell):
```powershell
./Patch-Library-LegacySocket -InputFile 'library-original.swf' -OutputFile 'library.swf'

# Use custom ffdec.jar
./Patch-Library-LegacySocket -InputFile 'library-original.swf' -OutputFile 'library.swf' -FFDec 'ffdec.jar'
```

## [Patch-Prelauncher-Local.ps1](Patch-Prelauncher-Local.ps1)

PowerShell script that patches `Prelauncher.swf` (`http://s2.protanki-online.com/Prelauncher.swf`) to use custom loader, game library, game and resource server configuration.  
Requires [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler) to be installed.  

| Argument         | Type      | Description                                                      | Default value                            |
|------------------|-----------|------------------------------------------------------------------|------------------------------------------|
| `InputFile`      | `string`  | Prelauncher SWF to patch                                         |                                          |
| `OutputFile`     | `string`  | Patched SWF file                                                 |                                          |
| `FFDec`          | `string`  | Path to `ffdec.jar` file                                         | `C:\Program Files (x86)\FFDec\ffdec.jar` |
| `ConfigFile`     | `string?` | Path / URL to the configuration file                             | `socket.cfg`                             |

Example configuration file:
```json
{
  "ip": "127.0.0.1",
  "port": 1337,
  "loader": "Loader.swf",
  "library": "library.swf",
  "resources": "http://127.0.0.1:8080/resource"
}
```

Example usage (PowerShell):
```powershell
# Default configuration file (socket.cfg)
./Patch-Prelauncher-Local -InputFile 'Prelauncher-original.swf' -OutputFile 'Prelauncher.swf'

# Local configuration file
./Patch-Prelauncher-Local -InputFile 'Prelauncher-original.swf' -OutputFile 'Prelauncher.swf' -ConfigFile 'my-config.json'

# Configuration file on the remote server
./Patch-Prelauncher-Local -InputFile 'Prelauncher-original.swf' -OutputFile 'Prelauncher.swf' -ConfigFile 'http://127.0.0.1/socket.cfg'

# Use custom ffdec.jar
./Patch-Prelauncher-Local -InputFile 'Prelauncher-original.swf' -OutputFile 'Prelauncher.swf' -FFDec 'ffdec.jar'
```

## [Patch-Library-Socket.ps1](Patch-Library-Socket.ps1)

PowerShell script that patches `library.swf` (`http://s2.protanki-online.com/library.swf`) to use custom game and/or resource server.  
Requires [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler) to be installed.  
The minimum supported game version is `library-20220501-221826`.

| Argument         | Type      | Description                                                      | Default value                            |
|------------------|-----------|------------------------------------------------------------------|------------------------------------------|
| `InputFile`      | `string`  | Game SWF to patch                                                |                                          |
| `OutputFile`     | `string`  | Patched SWF file                                                 |                                          |
| `FFDec`          | `string`  | Path to `ffdec.jar` file                                         | `C:\Program Files (x86)\FFDec\ffdec.jar` |
| `GameServer`     | `string?` | Game server endpoint in `IP:port` format (e.g. `127.0.0.1:1337`) |                                          |
| `ResourceServer` | `string?` | Resource server URL (e.g. `http://127.0.0.1:8080/resource`)      |                                          |

Example usage (PowerShell):
```powershell
# Change game server
./Patch-Library-Socket -InputFile 'library-original.swf' -OutputFile 'library.swf' -GameServer '127.0.0.1:1337'

# Change resource server
./Patch-Library-Socket -InputFile 'library-original.swf' -OutputFile 'library.swf' -ResourceServer 'http://127.0.0.1:8080/resource'

# Change both game and resource server
./Patch-Library-Socket -InputFile 'library-original.swf' -OutputFile 'library.swf' -GameServer '127.0.0.1:1337' -ResourceServer 'http://127.0.0.1:8080/resource'

# Use custom ffdec.jar
./Patch-Library-Socket -InputFile 'library-original.swf' -OutputFile 'library.swf' -FFDec 'ffdec.jar' -GameServer '127.0.0.1:1337'
```

## [packet-log.patch.txt](packet-log.patch.txt)

Patch (manual applying via [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler)) to log incoming and outgoing game packets.  
Log file is located at `$Desktop/packets.txt`.

## [packet2map.js](packet2map.js)

Converts battle join packets to the server map file (`data/maps/$name/$theme.json`).

Input format:
```json
{"resources":[...]}
{"resources":[...]}
{"resources":[...]}
{"kick_period_ms":125000,"map_id":...}
```

Alternative input format:
```json
[...]
[...]
[...]
{"kick_period_ms":125000,"map_id":...}
```

Example usage (PowerShell):
```powershell
Get-Content battle.txt | node ./packet2map.js | Set-Content map.json
```

## [strip-packets.js](strip-packets.js)

Extracts resource and battle model init packets from dump.

Example usage (PowerShell):
```powershell
Get-Content battle.txt | node ./strip-packets.js | node ./packet2map.js | Set-Content map.json
```
