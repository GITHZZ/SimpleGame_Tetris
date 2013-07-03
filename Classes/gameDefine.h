/*
 *  defAndCommand.h
 *  Tetris_3
 *
 *  Created by 何遵祖 on 12-5-17.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

//砖块状态
typedef enum blockState {
	Empty_Cell=1,//空的单元格
	Alive_Cell=2,//活动单元格
	Fix_Cell=3,//固定单元格
}blockState;

//砖块运动状态
typedef enum BlockRunState{
	Cell_Falling=4,//正在下落
	Cell_Static=5,//静止中.
}BlockRunState;

//砖块的种类(7种）
typedef enum BlockCoupleType {
	S=6,
	T=7,
	Z=8,
	L=9,
	J=10,
	O=11,
	I=12,
}BlockCoupleType;

//方块文件名字
#define BLOCK_FILENAME			    @"block.png"

//背景音乐
#define BACKGROUND_MUSIC_FILENAME   @"bg_Sound.m4v"

//初始位置参考坐标
#define ORIGIN_BUTTOM_POINTX		2//底部坐标原点

//方块实际可移动区域，长度和宽度
#define GAME_MOVING_MAX_X			13
#define GAME_MOVING_MAX_Y			26

//砖块方框数组大小
#define BLOCK_LINE_ROW				4
#define BLOCK_LINE_COL				4

//砖块屏幕的横列数目
#define GAME_LINE_ROW				30
#define GAME_LINE_COL				20
	
//控制层的标签
#define GAME_CONTROLLER_LAYER_TAG   100

//方块初始化位置
#define BLOCK_BEGINING_POSX			6
#define BLOCK_BEGINING_POSY			25

//坐标标签(tag)
#define GAME_SCORE_COUNT_TAG		99
#define GAME_LINE_COUNT_TAG			98
#define GAME_LEVEL_COUNT_TAG		97

#define GAME_SCORE_TAG				96
