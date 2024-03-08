Cfg = Cfg or {}

Cfg.Data = {

    Framework = {
        ['type'] = 'QBCore', -- ESX/QBCore
        -- ESX
        ['sharedObj'] = 'esx:getSharedObject',
        -- QBCore
        ['coreName'] = 'qb-core',
        ['triggerName'] = 'QBCore',
    },

    Locales = {
        -- Notify Error
        ['error_Title'] = 'Error',
        ['error_Message'] = 'Your announcement was not sent ~n~because it contained illegal strings',

        -- Announce
        ['announce_Description'] = 'Send an announcement to all players',
        ['announce_Title'] = 'Broadcast',
        -- Announcement Error
        ['announce_errorTitle'] = 'Error',
        ['announce_noPerms'] = 'You do not have the required permissions to execute this command',
        ['announce_playerData'] = 'Player data could not be retrieved',
    },

    forbiddenStrings = {
        '<video',
        '<img',
        '<script',
        'http://',
        'https://',
        '.png',
        '.jpg',
        '.jpeg'
    },

    Notify = {
        maxDisplayed = 6,
        types = {
            [0] = 'rgb(20, 63, 219)',   -- Default
            [1] = 'rgb(64, 117, 216)',   -- Info
            [2] = 'rgb(64, 216, 97)',   -- Success
            [3] = 'rgb(216, 181, 64)',   -- Warning
            [4] = 'rgb(216, 64, 64)',    -- Error

            -- Extra
            ['primary'] = 'rgb(20, 212, 219)',
            ['ems'] = 'linear-gradient(180deg, rgba(255,0,0,1) 25%, rgba(0,41,255,1) 100%)',
        },

        sound = {
            ['dictName'] = 'ATM_WINDOW',
            ['soundName'] = 'HUD_FRONTEND_DEFAULT_SOUNDSET'
        }
    },

    Announce = {
        types = {
            [0] = 'rgb(20, 63, 219)',   -- Default
            [1] = 'rgb(64, 117, 216)',   -- Info
            [2] = 'rgb(64, 216, 97)',   -- Success
            [3] = 'rgb(216, 181, 64)',   -- Warning
            [4] = 'rgb(216, 64, 64)',    -- Error

        },

        -- Announcement Command
        hasPerms = { 'admin' },
        cmdName = 'announce',
        time = 10, -- In Seconds
        type = 1,
        sound = {
            ['dictName'] = 'Dropped',
            ['soundName'] = 'HUD_FRONTEND_MP_COLLECTABLE_SOUNDS'
        }
    }

}

