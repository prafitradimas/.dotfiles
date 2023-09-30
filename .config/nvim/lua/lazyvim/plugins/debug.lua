return {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
        {
            "mason.nvim",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                vim.list_extend(
                    opts.ensure_installed,
                    { "gomodifytags", "impl", "gofumpt", "goimports-reviser", "delve", "js-debug-adapter" }
                )
            end,
        },
        {
            "leoluz/nvim-dap-go",
            config = true,
        },
    },
    opts = function()
        local dap = require("dap")
        if not dap.adapters["pwa-node"] then
            require("dap").adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    -- 💀 Make sure to update this path to point to your installation
                    args = {
                        require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                            .. "/js-debug/src/dapDebugServer.js",
                        "${port}",
                    },
                },
            }
        end
        for _, language in ipairs({ "typescript", "javascript" }) do
            if not dap.configurations[language] then
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                }
            end
        end
    end,
}
