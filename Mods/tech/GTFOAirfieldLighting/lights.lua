local function add_gtfo_static(shape, title)
    add_surface_unit({
        Name = shape, DisplayName = _(title), ShapeName = shape,
        Life = 10, Rate = 1, category = "Fortification",
        SeaObject = false, isPutToWater = false, numParking = 0,
        shape_table_data = {{
            file = shape, life = 10, username = shape,
            desrt = "self", classname = "lLandVehicle", positioning = "BYNORMAL",
        }},
        mapclasskey = "P0091000076",
        attribute = {wsType_Static, wsType_Standing},
    })
end
for _,style in ipairs({"Elevated", "Flush"}) do
    for _,kind in ipairs({"Omni", "Directional"}) do
        if not (style == "Flush" and kind == "Directional") then
        for _,color in ipairs({"Blue", "White", "Green", "Red"}) do
            local shape = "GTFO_" .. style .. "_" .. kind .. "_" .. color
            add_gtfo_static(shape, "GTFO | " .. style .. " " .. kind .. " - " .. color)
        end
        end
    end
end
add_gtfo_static("GTFO_Approach_Light_Array_856m", "GTFO | Approach Lights - 856m Array")
add_gtfo_static("GTFO_Parking_Floodlight_Pole_12m", "GTFO | Parking Floodlight Pole")

add_gtfo_static("GTFO_Runway_Threshold_80ft_RedGreen", "GTFO | Runway Threshold - 80ft Red/Green")
