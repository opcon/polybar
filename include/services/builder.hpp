#ifndef _SERVICES_BUILDER_HPP_
#define _SERVICES_BUILDER_HPP_

#include <string>
#include <memory>

#include "drawtypes/animation.hpp"
#include "drawtypes/bar.hpp"
#include "drawtypes/icon.hpp"
#include "drawtypes/label.hpp"
#include "drawtypes/ramp.hpp"

#define DEFAULT_SPACING -1

class Lemonbuddy;

class Builder
{
  public:
    enum Alignment {
      ALIGN_NONE,
      ALIGN_LEFT,
      ALIGN_CENTER,
      ALIGN_RIGHT,
    };

  private:
    std::string output;
    bool lazy_closing = true;

    Alignment alignment = ALIGN_NONE;

    // counters
    int A = 0, B = 0, F = 0, T = 0, U = 0, o = 0, u = 0;
    int T_value = 1;
    std::string B_value = "", F_value = "", U_value = "";

    void tag_open(char tag, const std::string& value);
    void tag_close(char tag);

    void align_left();
    void align_center();
    void align_right();

  public:
    Builder(bool lazy_closing = true) : lazy_closing(lazy_closing){}

    void set_lazy_closing(bool mode) { this->lazy_closing = mode; }

    std::string flush();

    void append(const std::string& node);
    void append_module_output(Alignment alignment, const std::string& module_output, bool margin_left = true, bool margin_right = true);

    void node(const std::string& str, bool add_space = false);
    void node(const std::string& str, int font_index, bool add_space = false);

    void node(drawtypes::Bar *bar, float percentage, bool add_space = false);
    void node(std::unique_ptr<drawtypes::Bar> &bar, float percentage, bool add_space = false);

    void node(drawtypes::Label *label, bool add_space = false);
    void node(std::unique_ptr<drawtypes::Label> &label, bool add_space = false);

    void node(drawtypes::Icon *icon, bool add_space = false);
    void node(std::unique_ptr<drawtypes::Icon> &icon, bool add_space = false);

    void node(drawtypes::Ramp *ramp, float percentage, bool add_space = false);
    void node(std::unique_ptr<drawtypes::Ramp> &ramp, float percentage, bool add_space = false);

    void node(drawtypes::Animation *animation, bool add_space = false);
    void node(std::unique_ptr<drawtypes::Animation> &animation, bool add_space = false);

    void offset(int pixels = 0);
    void space(int width = DEFAULT_SPACING);
    void remove_trailing_space(int width = DEFAULT_SPACING);

    void font(int index);
    void font_close(bool force = false);

    void background(const std::string& color);
    void background_close(bool force = false);

    void color(const std::string& color);
    void color_alpha(const std::string& alpha);
    void color_close(bool force = false);

    void line_color(const std::string& color);
    void line_color_close(bool force = false);

    void overline(const std::string& color = "");
    void overline_close(bool force = false);

    void underline(const std::string& color = "");
    void underline_close(bool force = false);

    void invert();

    void cmd(int button, std::string action, bool condition = true);
    void cmd_close(bool force = false);
};

#endif