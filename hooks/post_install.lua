--- Extension point, called after PreInstall, compiles bfs from source
--- @param ctx table
--- @field ctx.rootPath string SDK installation directory
function PLUGIN:PostInstall(ctx)
    local rootPath = ctx.rootPath

    -- Find the extracted source directory (bfs-{version})
    local find_cmd = string.format('ls -d "%s"/bfs-* 2>/dev/null | head -1', rootPath)
    local handle = io.popen(find_cmd)
    if not handle then
        error("Failed to find extracted source directory")
    end
    local srcDir = handle:read("*l")
    handle:close()

    if not srcDir or srcDir == "" then
        error("Could not find bfs source directory in " .. rootPath)
    end

    -- Build bfs using configure && make
    -- RELEASE=y enables optimizations
    -- We'll install to the rootPath
    local build_cmd = string.format(
        'cd "%s" && ./configure RELEASE=y && make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 2)',
        srcDir
    )

    print("Compiling bfs from source...")
    local result = os.execute(build_cmd)
    if not result then
        error("Failed to compile bfs. Make sure you have a C compiler (gcc/clang) and make installed.")
    end

    -- Create bin directory in rootPath and copy the binary
    local binDir = rootPath .. "/bin"
    os.execute(string.format('mkdir -p "%s"', binDir))

    -- bfs binary is built in the source directory's bin/ folder
    local copy_cmd = string.format('cp "%s/bin/bfs" "%s/bfs"', srcDir, binDir)
    result = os.execute(copy_cmd)
    if not result then
        -- Try copying from source root (older versions)
        copy_cmd = string.format('cp "%s/bfs" "%s/bfs"', srcDir, binDir)
        result = os.execute(copy_cmd)
        if not result then
            error("Failed to copy bfs binary to bin directory")
        end
    end

    -- Make executable
    os.execute(string.format('chmod +x "%s/bfs"', binDir))

    -- Clean up source directory to save space
    os.execute(string.format('rm -rf "%s"', srcDir))

    print("bfs compiled successfully!")
end
