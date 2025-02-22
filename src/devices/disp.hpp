#pragma once

#include <iostream>
#include <array>
#include <stdint.h>
#include <thread>

#include "olcPixelGameEngine.h"
// #include "font.h"

class Disp : public olc::PixelGameEngine {
public:
    std::array<uint8_t, 0xffff> vram;

    Disp() {
        sAppName = "Mocha";
    }
public:
    bool OnUserCreate() override;
    bool OnUserUpdate(float fElapsedTime) override;
    void DispDraw(uint8_t r, uint8_t g, uint8_t b, uint8_t x, uint8_t y);
    std::array<uint8_t, 3> byteToRGB(uint8_t color);
};