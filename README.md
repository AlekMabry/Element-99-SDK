# Element 99 SDK
E99 SDK is a 3D game engine developed for GameMaker:Studio 1.4. It
supports physically based rendering (PBR), AABB collision detection,
and a custom map format.

## PBR

<img src="screenshots/E99_SDK_PBRMaterials.jpg" alt="PBR Materials in E99 SDK"/>

## Map Format
The engine lacks a map editor, so maps are stored in a human-editable .JSON format.

```
{
    "models": 
    [
        {
            "id": 1,
            "x": 1408,
            "y": 640,
            "z": 0,
            "rotationx": 0,
            "rotationy": 0,
            "rotationz": 0,
            "texture": "Truss_256_BaseColor.png",
            "normal": "Truss_256_Normal.png",
            "material": "Truss_256_OcclusionRoughnessMetallic.png",
            "model": "Truss_256.E99",
            "shader": "pbr"
        },
        {...},
        {...}
    ],
    "collisionblocks":
	[
		{
		"id": 1,
		"x1": -1280.0,
		"y1": -512.0,
		"z1": -512.0,
		"x2": 1280.0,
		"y2": 512.0,
		"z2": -256.0
		},
        {...},
        {...}
    ]
}
```

# Building
Copy the `Element_99_SDK` asset directory to `%localappdata%`.
`Element-99-SDK.project.gmx` can be opened and run with GM:S versions up to 1.4.

## Compiling Models
Models can be exported from Blender using ![this addon](https://martincrownover.com/blender-addon-gm3d/).