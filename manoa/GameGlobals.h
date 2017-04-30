#define kBaseGameWidth 320.0f
#define kBaseGameHeight 480.0f

// Game Region Constants
#define kNumberItemColumns 8
#define kNumberItemRows 12
#define kFirstItemRow 12

// Button Names
#define kStartRandomButtonName @"start button - pattern:random"
#define kStartA1ButtonName @"start button - pattern:a1"
#define kUserButtonName @"user button"
#define kUserScreenCancelButtonName @"user screen - cancel"
#define kUserScreenOkButtonName @"user screen - ok"

//#define kDefaultGravityXValue 200.0f
#define kGravityYMinValue 80.0f
#define kGravityYMaxValue 200.0f
//#define kDefaultGravityYHalfValue 100.0f
#define kActorMaxVel 200.0f

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define kAddLevelResultsForUserNameURL [NSURL URLWithString:@"http://api.imberstudios.com/drunken-adventure/level-results/"]


typedef struct ColorData
{
	CGFloat r;
	CGFloat g;
	CGFloat b;
	CGFloat a;
} Color;

static inline Color
ColorMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    Color color;
    
    color.r = r;
    color.g = g;
    color.b = b;
    color.a = a;
    
    return color;
}

static inline Color ColorMakeFromUIColor(UIColor* uiColor)
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

typedef enum
{
    GameZoneModeUnknown,
    GameZoneModeRandom = 1,
    GameZoneModeA1
} GameZoneMode;

static inline NSString* GetGameZoneModeName(GameZoneMode gameZoneMode)
{
    NSString* name = @"Unknown GameZoneMode";
    
    switch (gameZoneMode)
    {
        case GameZoneModeRandom:
            name = @"Random";
            break;
        case GameZoneModeA1:
            name = @"A1";
            break;
        case GameZoneModeUnknown:
        default:
            break;
    }
    
    return name;
}

typedef enum
{
    ActorStateFalling = 1,
    ActorStateFallingPillow,
    ActorStateSplat,
    ActorStateSplatPillow,
    ActorStateSleeping
} ActorState;
