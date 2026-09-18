function [dim , Search_Range] = get_info_func(what_func)

    switch what_func
        case 1
            dim   = 9;
            Search_Range       	= [-8192, 8192];
        case 2
            dim   = 16;
            Search_Range       	= [-16384, 16384];
        case 3
            dim   = 18;
            Search_Range       	= [-4,4];
        case 4
            dim   = 10;
            Search_Range       	= [-100,100];
        case 5
            dim   = 10;
            Search_Range       	= [-100,100];
        case 6
            dim   = 10;
            Search_Range       	= [-100,100];
        case 7
            dim   = 10;
            Search_Range       	= [-100,100];
        case 8
            dim   = 10;
            Search_Range       	= [-100,100];
        case 9
            dim   = 10;
            Search_Range       	= [-100,100];
        case 10
            dim   = 10;
            Search_Range       	= [-100,100];
    end
end