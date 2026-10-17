declare_plugin("GTFO Airfield Lighting by Schilly", {
    installed = true,
    dirName = current_mod_path,
    version = "0.0.1",
    state = "installed",

    shortName = 'GTFO Airfield Lighting',
    fileMenuName = "GTFO - Airfield Lighting",
    info = _("This addon includes several different lighting commonly found at airfields. Useful for creating improvised runways and/or adding lights to FARPs. https://globaltaskforceoverlord.org"),
    Skins	=
	{
		{
			name	= "Airfield Lighting",
			dir		= "Theme"
		},
	},
})

mount_vfs_model_path(current_mod_path .. "/Shapes")
mount_vfs_texture_path(current_mod_path .. "/Textures")
dofile(current_mod_path .. "/lights.lua")
plugin_done()
