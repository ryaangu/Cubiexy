///block_init();

//Enums
enum BLOCK 
{
    NULL            = 0,
    GRASS           = 1,
    DIRT            = 2,
    LAVA            = 3,
    STONE           = 4,
    LEAVES          = 5,
    LOGS            = 6, 
    DIRT_BACKGROUND = 7
}


//Add the blocks to the database
database_add_block(BLOCK.NULL, false, false);
database_add_block(BLOCK.GRASS, true, true);
database_add_block(BLOCK.DIRT, true, true);
database_add_block(BLOCK.LAVA, true, false);
database_add_block(BLOCK.STONE, true, true);
database_add_block(BLOCK.LEAVES, false, true);
database_add_block(BLOCK.LOGS, false, true);
database_add_block(BLOCK.DIRT_BACKGROUND, false, true);
