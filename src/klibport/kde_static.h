/*
 * @file qtest_kde.h
 *
 * Simple kcal porting stuff for Maemo.
 *
  Contact: Alvaro Manera <alvaro.manera@nokia.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Library General Public
  License as published by the Free Software Foundation; either
  version 2 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Library General Public License for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; see the file COPYING.LIB.  If not, write to
  the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA 02110-1301, USA.
 */
#ifndef _KDE_STATIC_H
#define _KDE_STATIC_H

typedef void (*KdeCleanUpFunction)();

/**
 * @internal
 *
 * Helper class for K_GLOBAL_STATIC to clean up the object on library unload or application
 * shutdown.
 */
class KCleanUpGlobalStatic
{
    public:
        KdeCleanUpFunction func;

        inline ~KCleanUpGlobalStatic() { func(); }
};

/*----------------------------------------------------------------------------*/
#define K_GLOBAL_STATIC_STRUCT_NAME(NAME)

#define K_GLOBAL_STATIC_WITH_ARGS(TYPE, NAME, ARGS)                            \
static QBasicAtomicPointer<TYPE > _k_static_##NAME = Q_BASIC_ATOMIC_INITIALIZER(0); \
static bool _k_static_##NAME##_destroyed;                                      \
static struct K_GLOBAL_STATIC_STRUCT_NAME(NAME)                                \
{                                                                              \
    inline bool isDestroyed() const                                            \
{                                                                          \
        return _k_static_##NAME##_destroyed;                                   \
}                                                                          \
    inline bool exists() const                                                 \
{                                                                          \
        return _k_static_##NAME != 0;                                          \
}                                                                          \
    inline operator TYPE*()                                                    \
{                                                                          \
        return operator->();                                                   \
}                                                                          \
    inline TYPE *operator->()                                                  \
{                                                                          \
        if (!_k_static_##NAME) {                                               \
            if (isDestroyed()) {                                               \
                qFatal("Fatal Error: Accessed global static '%s *%s()' after destruction. " \
                       "Defined at %s:%d", #TYPE, #NAME, __FILE__, __LINE__);  \
}                                                                  \
            TYPE *x = new TYPE ARGS;                                           \
            if (!_k_static_##NAME.testAndSetOrdered(0, x)                      \
                && _k_static_##NAME != x ) {                                   \
                delete x;                                                      \
} else {                                                           \
                static KCleanUpGlobalStatic cleanUpObject = { destroy };       \
}                                                                  \
}                                                                      \
        return _k_static_##NAME;                                               \
}                                                                          \
    inline TYPE &operator*()                                                   \
{                                                                          \
        return *operator->();                                                  \
}                                                                          \
    static void destroy()                                                      \
{                                                                          \
        _k_static_##NAME##_destroyed = true;                                   \
        TYPE *x = _k_static_##NAME;                                            \
        _k_static_##NAME = 0;                                                  \
        delete x;                                                              \
}                                                                          \
} NAME;

#endif
