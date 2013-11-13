//
//  Utils.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 13.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#ifndef WarBot_Utils_h
#define WarBot_Utils_h

#define ARC4RANDOM_MAX      0x100000000

#define DEFAULT_PROGRAM_LENGTH 32
#define DEFAULT_AVAILIABLE_LENGTH 128
#define DEFAULT_TRIGGERS_LENGTH 16
#define DEFAULT_REGISTERS_LENGTH 8

#define DEFAULT_TURRET_ENERGY 100;
#define DEFAULT_TURRET_CHARGES 100;
#define DEFAULT_CHASSIS_ENERGY 100;
#define DEFAULT_FUEL 100;

#define DEFAULT_TIME_INTERVAL 0.5

#define DEFAULT_COLS 5
#define DEFAULT_CELL_SIZE 64

CG_INLINE CGFloat
AJDistance(CGPoint p1, CGPoint p2)
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

typedef enum {
    kChassisTypeWheel = 0,
    kChassisTypeTrack,
    kChassisTypeFoot
    
} AJChassisType;

typedef enum {
    kTurretTypeEmpty = 0,
    kTurretTypeLazer,
    kTurretTypeCannon,
    
} AJTurretType;

typedef enum {
    kTriggerWallCollision = 0,
    kTriggerHitDetect,
    kTriggerWaterDetect
} AJTriggersType;

typedef enum {
    kCommandTypeDefault = 0,
    kCommandTypeBot,
    kCommandTypeProg
} kCommandType;

typedef enum {
    kRegistersA = 0,    // return register
    kRegistersB,        // program counter
    kRegistersC,        // wall contact register
    kRegistersD,
    kRegistersE,
    kRegistersF,
    kRegistersG,
    kRegistersH
    
} kRegisters;

static const uint32_t botCategory       = 0x1 << 0;
static const uint32_t wallCategory      = 0x1 << 1;
static const uint32_t bulletCategory    = 0x1 << 2;

#endif
