#include <iomanip>
#include <utility>

#include "errors.hpp"
#include "utils/color.hpp"
#include "utils/string.hpp"
#include "x11/color.hpp"

POLYBAR_NS

mutex_wrapper<std::unordered_map<string, color>> g_colorstore;

const color& g_colorempty{"#00000000"};
const color& g_colorblack{"#ff000000"};
const color& g_colorwhite{"#ffffffff"};

color::color(string hex) : m_source(hex) {
  if (hex.empty()) {
    throw application_error("Cannot create color from empty hex");
  }

  m_value = std::strtoul(&hex[1], nullptr, 16);
  m_color = color_util::premultiply_alpha(m_value);
}

string color::source() const {
  return m_source;
}

color::operator XRenderColor() const {
  XRenderColor x{};
  x.red = color_util::red_channel<uint16_t>(m_color);
  x.green = color_util::green_channel<uint16_t>(m_color);
  x.blue = color_util::blue_channel<uint16_t>(m_color);
  x.alpha = color_util::alpha_channel<uint16_t>(m_color);
  return x;
}

color::operator string() const {
  return color_util::hex<uint8_t>(m_color);
}

color::operator uint32_t() {
  return static_cast<const color&>(*this);
}

color::operator uint32_t() const {
  return m_color;
}

const color& color::parse(string input, const color& fallback) {
  if (input.empty()) {
    throw application_error("Cannot parse empty color");
  } else if ((input = color_util::parse_hex(move(input))).empty()) {
    return fallback;
  }

  std::lock_guard<decltype(g_colorstore)> guard(g_colorstore);
  auto it = g_colorstore.find(input);
  if (it == g_colorstore.end()) {
    it = g_colorstore.emplace_hint(it, make_pair(input, color{input}));
  }
  return it->second;
}

const color& color::parse(string input) {
  return parse(move(input), g_colorempty);
}

POLYBAR_NS_END
