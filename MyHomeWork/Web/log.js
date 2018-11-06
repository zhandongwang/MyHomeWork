window.bridge.log = function(msg) {
    
    window.bridge.invoke("me.octree.bridge.log", "log:", null, msg)
}

window.bridge.log("hello")


