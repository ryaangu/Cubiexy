///world_generate();

//Get the generation positions
var _air_x        = 0,
    _air_y        = 20,
    _air_y_change = 0,
    _air_y_min    = 300 div BLOCK_SIZE;
    
var _dist_y        = 10,
    _dist_y_random = 30;
    
//Loop through world x
while (_air_x < CHUNK_MAX_HORIZONTAL * CHUNK_SIZE)
{
    //Random generation values
    _air_y_change = irandom(4) - 3;
    _air_y       += _air_y_change;
    _air_y        = clamp(_air_y, _air_y_min, WORLD_HEIGHT/5);
    
    //Generate blocks
    
    //Foreground
    ds_grid_set(global.world_grid[LAYER.FOREGROUND], _air_x, _air_y, BLOCK.GRASS);
    ds_grid_set_region(global.world_grid[LAYER.FOREGROUND], _air_x, _air_y + 1, _air_x, _air_y + 1 + _dist_y + irandom(_dist_y_random), BLOCK.DIRT);
    ds_grid_set_region(global.world_grid[LAYER.FOREGROUND], _air_x, _air_y + ds_grid_height(global.world_grid[LAYER.FOREGROUND]) - 37, _air_x, ds_grid_height(global.world_grid[LAYER.FOREGROUND]) - 1, BLOCK.STONE);
    ds_grid_set_region(global.world_grid[LAYER.FOREGROUND], _air_x, _air_y + ds_grid_height(global.world_grid[LAYER.FOREGROUND]) - 20, _air_x, ds_grid_height(global.world_grid[LAYER.FOREGROUND]) - 1, BLOCK.LAVA);
    
    //Background
    ds_grid_set(global.world_grid[LAYER.BACKGROUND], _air_x, _air_y, BLOCK.DIRT_BACKGROUND);
    ds_grid_set_region(global.world_grid[LAYER.BACKGROUND], _air_x, _air_y + 1, _air_x, _air_y + 1 + _dist_y + irandom(_dist_y_random), BLOCK.DIRT_BACKGROUND);
    ds_grid_set_region(global.world_grid[LAYER.BACKGROUND], _air_x, _air_y + ds_grid_height(global.world_grid[LAYER.BACKGROUND]) - 37, _air_x, ds_grid_height(global.world_grid[LAYER.BACKGROUND]) - 1, BLOCK.DIRT_BACKGROUND);
    ds_grid_set_region(global.world_grid[LAYER.BACKGROUND], _air_x, _air_y + ds_grid_height(global.world_grid[LAYER.BACKGROUND]) - 20, _air_x, ds_grid_height(global.world_grid[LAYER.BACKGROUND]) - 1, BLOCK.DIRT_BACKGROUND);
    
    
    //Increase the air x
    _air_x++;
}
