cmd_Release/dealer.node := ln -f "Release/obj.target/dealer.node" "Release/dealer.node" 2>/dev/null || (rm -rf "Release/dealer.node" && cp -af "Release/obj.target/dealer.node" "Release/dealer.node")
