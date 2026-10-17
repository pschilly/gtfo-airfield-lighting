declare_plugin("GTFO Airfield Lighting by Schilly", {
    installed = true,
    dirName = current_mod_path,
    version = "0.0.2",
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
-- Two independent texture archives, mounted by the same mod.
mount_vfs_texture_path(current_mod_path .. "/Textures/GTFO_Airfield_Textures.zip")
mount_vfs_texture_path(current_mod_path .. "/Textures/GTFO_PAPI_Textures.zip")
dofile(current_mod_path .. "/lights.lua")
plugin_done()
