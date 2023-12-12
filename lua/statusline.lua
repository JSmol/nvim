-- custom backgrounds for transparent terminal --
local auto = require('lualine.themes.auto')
auto.normal.b.bg = 'NONE'
auto.normal.c.bg = 'NONE'

local function lsp_progress()
    -- TODO: fix this
    -- local messages = vim.lsp.status()
    -- if #messages == 0 then
    --   return ""
    -- end
    -- local status = {}
    -- for _, msg in pairs(messages) do
    --   table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
    -- end
    -- local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    -- local ms = vim.loop.hrtime() / 1000000
    -- local frame = math.floor(ms / 120) % #spinners
    -- return table.concat(status, " | ") .. " " .. spinners[frame + 1]
    return "🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢"
end

local modules = require('lualine_require').lazy_require {
  highlight = 'lualine.highlight',
}
local settings = require("grapple.settings")
local scope = require("grapple.scope")
local Path = require('plenary.path')
local function grapple_tags()
    local key = require("grapple").key()
    local scope_resolver = scope.find_resolver(settings.scope)
    local scope_path = scope.get(scope_resolver)
    local tags = require("grapple").tags()
    local str = ''
    for _, v in ipairs(tags) do
        local fp = Path:new(v.file_path)
        local b = vim.fn.bufnr(v.file_path)
        fp = fp:make_relative(scope_path)
        fp = vim.fn.pathshorten(vim.fn.fnamemodify(fp, ':p:.'))
        local is_modified = b >= 0 and vim.api.nvim_buf_get_option(b, 'modified')
        if v.key == key then
            str = str .. modules.highlight.format_highlight('a', true) .. ' ' .. v.key .. ': ' .. (is_modified and '󰴓 ' or '') .. fp .. ' '
        else
            str = str .. modules.highlight.format_highlight('a', false) .. ' ' .. v.key .. ': ' .. (is_modified and '󰴓 ' or '') .. fp .. ' '
        end
    end
    return str
end

require('lualine').setup({

    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = ' ', right = ' '},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch', 'diff', 'diagnostics',
        },
        lualine_c = {
            'filetype',
            {
                'filename',
                path=1
            }
        },
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {lsp_progress},
        lualine_y = {},
        lualine_z = {'location'},
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },

    tabline = {
        -- lualine_a = {
            -- {
            --     'buffers',
            --     show_filename_only = false,
            --     use_mode_colors = true,
            -- }
        -- },
        lualine_a = {grapple_tags},
        lualine_b = {},
        lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        lualine_z = {
            {
                'tabs',
                use_mode_colors = true,
                symbols = { modified = ' 󰴓' },
            }
        }
    },

    winbar = {
        -- lualine_a = {'filename'},
    },

    inactive_winbar = {
        -- lualine_c = {'filename'},
    },

    extensions = {}

})
