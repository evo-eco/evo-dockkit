 
 # dockkit
 
 This repo is intended to be a submodule in your repo, so that you can have a clean Dockerized test environment/scaffold.
 
    $ docker-compose up

#### get started

```bash
$ ./test-clean-vpnd.sh
```

#### scripts


 * `./build-shell-vpnd.sh`
 * `docker-compose -f docker-compose.yml down`
 
 * `./test-clean-vpnd.sh` ()
 * `./test-again-vpnd.sh`
 
 * `./reset-shell-vpnd.sh`

#### bash-oo-framework
 
 * https://github.com/niieani/bash-oo-framework/tree/master/lib
 
```bash
source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/lib/bash-oo-framework/lib/oo-bootstrap.sh"

import util/

echo "$(UI.Color.Red)colors$(UI.Color.Default)"
```
