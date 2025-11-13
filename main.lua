---@diagnostic disable: duplicate-set-field, undefined-global, lowercase-global
-- Arknights Mod - 主入口文件
-- 定义全局命名空间和模块结构

-- 注册 Mod
Ark_MOD = RegisterMod("Arknights", 1)

-- 全局命名空间 - 唯一的全局变量
Ark = {
    -- 道具模块
    Item = {
        Variable = {
            Bool = {},
            Num = {},
            String = {}
        },
        Table = {},
        Info = {},
        Function = {
            Custom = {}
        }
    },
    -- 角色模块
    Character = {
        Variable = {
            Bool = {},
            Num = {},
            String = {}
        },
        Table = {},
        Info = {},
        Function = {
            Custom = {}
        }
    },
    -- 诅咒模块
    Curse = {
        Variable = {
            Bool = {},
            Num = {},
            String = {}
        },
        Table = {},
        Info = {},
        Function = {
            Custom = {}
        }
    },
    -- 敌人模块
    Enemy = {
        Variable = {
            Bool = {},
            Num = {},
            String = {}
        },
        Table = {},
        Info = {},
        Function = {
            Custom = {}
        }
    },
    -- 口袋道具模块
    Pocket = {
        Variable = {
            Bool = {},
            Num = {},
            String = {}
        },
        Table = {},
        Info = {},
        Function = {
            Custom = {}
        }
    }
}
-- 加载模块
include("scripts.item")
include("scripts.character")
include("scripts.curse")
include("scripts.enemy")
include("scripts.pocket")
include("scripts.EID")