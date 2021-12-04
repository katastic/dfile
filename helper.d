import allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A
import allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
Aimport allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;



/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A

	return val;
	}
A


	return val;
	}
A


	return val;
	}
A


	return val;
	}
A




/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A

	return val;
	}
A


	return val;
	}
A


	return val;
	}
A


	return val;
	}
A




/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A

	return val;
	}
A


	return val;
	}
A


	return val;
	}
A


	return val;
	}
A




/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A

	return val;
	}
A


	return val;
	}
A


	return val;
	}
A


	return val;
	}
A




/// UFCS - Helper functions 
/// see https://www.allegro.cc/manual/5/al_get_font_line_height
/// Font Height = Ascent + Descent
int h(const ALLEGRO_FONT *f)
	{
	return al_get_font_line_height(f);
	}


/// Font Ascent
int a(const ALLEGRO_FONT *f)
	{
	return al_get_font_ascent(f);
	}

/// Font Descent
int d(const ALLEGRO_FONT *f)
	{
	return al_get_font_descent(f);
	}

//helper functions using universal function call syntax.
int w(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_width(b);
	}

int h(ALLEGRO_BITMAP *b)
	{
	return al_get_bitmap_height(b);
	}


//Gosh, I love D's nested functions and templates.
void cap(T)(ref T val, T low, T high)
	{
	if(val < low){val = low; return;}
	if(val > high){val = high; return;}
	}

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}



// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}

v
v
v

// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}


// Cap and return value.
// better name for this? 
pure T cap_ret(T)(T val, T low, T high)
	{
	if(val < low){val = low; return val;}
	if(val > high){val = high; return val;}
	return val;
	}
A

	return val;
	}
A


	return val;
	}
A


	return val;
	}
A


	return val;
	}
A




A


	return val;
	}
A



A


	return val;
	}
A



A


	return val;
	}
A



A


	return val;
	}
A



A


	return val;
	}
A



A


	return val;
	}
A



A


	return val;
	}
A



525312522
