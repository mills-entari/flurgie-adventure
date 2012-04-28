#define kNumberItemColumns 8
#define kNumberItemRows 12
#define kFirstItemRow 12

typedef struct ColorData
{
	float r;
	float g;
	float b;
	float a;
} Color;

static inline Color
ColorMake(float r, float g, float b, float a)
{
    Color color;
    
    color.r = r;
    color.g = g;
    color.b = b;
    color.a = a;
    
    return color;
}

static inline Color
ColorMakeFromUIColor(UIColor* uiColor)
{
    Color color;
    
    [uiColor getRed:&color.r green:&color.g blue:&color.b alpha:&color.a];
    
    return color;
}

typedef enum
{
    GameCollisionTypeDefault = 1,
    GameCollisionTypeActor,
    GameCollisionTypeBounds,
    GameCollisionTypeGround,
    GameCollisionTypeItem
} GameCollisionType;


// Shapes only collide if they are in the same bit-planes. i.e. (a->layers & b->layers) != 0
// By default, a shape occupies all bit-planes.
typedef enum
{
    GameLayerActors = 1,
    GameLayerItems = 2
} GameLayer;
